import 'package:sqflite/sqflite.dart';
import 'package:students_control/core/database/database_helper.dart';
import 'package:students_control/core/utils/data_response.dart';
import 'package:students_control/features/courses/data/mapper/course_mapper.dart';
import 'package:students_control/features/courses/data/mapper/schedule_mapper.dart';
import 'package:students_control/features/courses/data/model/course_model.dart';
import 'package:students_control/features/courses/data/model/schedule_model.dart';
import 'package:students_control/features/courses/domain/entities/course.dart';
import 'package:students_control/features/courses/domain/entities/schedule.dart';
import 'package:students_control/features/courses/domain/repo/course_repository.dart';

class CourseRepositoryImpl implements CourseRepository {
  @override
  Future<DataResponse<List<Course>>> getAllCourses() async {
    final db = await DatabaseHelper.instance.database;

    try {
      final result = await db.query('courses');

      if (result.isEmpty) {
        return DataResponse.success(
          message: 'No se encontraron cursos',
          data: [],
        );
      }

      return DataResponse.success(
        data: result
            .map(
              (courseMap) =>
                  CourseMapper.toEntity(CourseModel.fromMap(courseMap)),
            )
            .toList(),
      );
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  @override
  Future<DataResponse<List<Course>>> getCoursesByName(String name) async {
    final db = await DatabaseHelper.instance.database;

    try {
      final result = await db.query(
        'courses',
        where: 'name = ?',
        whereArgs: [name],
      );

      if (result.isEmpty) {
        return DataResponse.success(
          message: 'No se encontraron cursos',
          data: [],
        );
      }

      return DataResponse.success(
        data: result
            .map(
              (courseMap) =>
                  CourseMapper.toEntity(CourseModel.fromMap(courseMap)),
            )
            .toList(),
      );
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  @override
  Future<DataResponse<Course>> addCourse(
    Course course,
    List<Schedule> schedules,
  ) async {
    final db = await DatabaseHelper.instance.database;

    try {
      return await db.transaction((txn) async {
        final courseModel = CourseMapper.toModel(course);
        final courseId = await txn.insert('courses', courseModel.toMap());

        for (final schedule in schedules) {
          final scheduleModel = ScheduleMapper.toModel(schedule);
          // We need to create a map and override course_id
          final scheduleMap = scheduleModel.toMap();
          scheduleMap['course_id'] = courseId;

          await txn.insert('schedules', scheduleMap);
        }

        return DataResponse.success(
          message: 'Curso creado correctamente',
          data: CourseMapper.toEntity(courseModel.copyWith(id: courseId)),
        );
      });
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  @override
  Future<DataResponse<List<Schedule>>> getSchedulesByCourseId(
    int courseId,
  ) async {
    final db = await DatabaseHelper.instance.database;

    try {
      final result = await db.query(
        'schedules',
        where: 'course_id = ?',
        whereArgs: [courseId],
        orderBy: 'day_of_week ASC, start_time ASC',
      );

      if (result.isEmpty) {
        return DataResponse.success(
          message: 'No se encontraron horarios',
          data: [],
        );
      }

      return DataResponse.success(
        data: result
            .map(
              (scheduleMap) =>
                  ScheduleMapper.toEntity(ScheduleModel.fromMap(scheduleMap)),
            )
            .toList(),
      );
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  @override
  Future<DataResponse<int>> countStudentsByCourseId(int courseId) async {
    final db = await DatabaseHelper.instance.database;

    try {
      final result = await db.rawQuery(
        '''
        SELECT COUNT(*) as count 
        FROM enrollments 
        WHERE course_id = ?
        ''',
        [courseId],
      );

      final count = Sqflite.firstIntValue(result) ?? 0;
      return DataResponse.success(data: count);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  @override
  Future<DataResponse<double>> getCourseAverage(int courseId) async {
    final db = await DatabaseHelper.instance.database;

    try {
      // 1. Get all assessments for the course
      final assessmentsResult = await db.query(
        'assessments',
        where: 'course_id = ?',
        whereArgs: [courseId],
      );

      if (assessmentsResult.isEmpty) {
        return DataResponse.success(data: 0.0);
      }

      // Map assessment ID to its percentage
      final assessmentPercents = {
        for (var a in assessmentsResult)
          a['id'] as int: (a['percent'] as num).toDouble(),
      };

      // 2. Get all grades for these assessments
      // We can use WHERE IN clause
      final assessmentIds = assessmentPercents.keys.join(',');
      if (assessmentIds.isEmpty) {
        return DataResponse.success(data: 0.0);
      }

      final gradesResult = await db.rawQuery(
        'SELECT * FROM grades WHERE assessment_id IN ($assessmentIds)',
      );

      if (gradesResult.isEmpty) {
        return DataResponse.success(data: 0.0); // No grades yet
      }

      // 3. Group grades by student
      final studentGrades = <int, List<Map<String, dynamic>>>{};
      for (var grade in gradesResult) {
        final studentId = grade['student_id'] as int;
        if (!studentGrades.containsKey(studentId)) {
          studentGrades[studentId] = [];
        }
        studentGrades[studentId]!.add(grade);
      }

      if (studentGrades.isEmpty) {
        return DataResponse.success(data: 0.0);
      }

      // 4. Calculate weighted score for each student
      double totalCourseScore = 0.0;
      int studentCountWithGrades = 0;

      for (var studentId in studentGrades.keys) {
        double studentTotalScore = 0.0;
        final grades = studentGrades[studentId]!;

        // Calculate student's final grade based on weighted assessments
        for (var grade in grades) {
          final assessmentId = grade['assessment_id'] as int;
          final score = (grade['score'] as num).toDouble();
          final percent = assessmentPercents[assessmentId] ?? 0.0;

          studentTotalScore += score * (percent / 100);
        }

        totalCourseScore += studentTotalScore;
        studentCountWithGrades++;
      }

      // 5. Calculate class average
      final average = totalCourseScore / studentCountWithGrades;
      // Round to 1 decimal place for cleaner display, or keep logic here and format in UI
      // Let's keep a bit of precision
      return DataResponse.success(data: average);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  @override
  Future<DataResponse<double>> getDailyAttendancePercentage(
    int courseId,
    DateTime date,
  ) async {
    final db = await DatabaseHelper.instance.database;

    try {
      // 1. Get total students enrolled
      final totalResult = await db.rawQuery(
        'SELECT COUNT(*) FROM enrollments WHERE course_id = ?',
        [courseId],
      );
      final totalStudents = Sqflite.firstIntValue(totalResult) ?? 0;

      if (totalStudents == 0) {
        return DataResponse.success(data: 0.0);
      }

      // 2. Get students present or late
      // Format date to ISO8601 YYYY-MM-DD
      final dateStr = date.toIso8601String().split('T').first;

      final presentResult = await db.rawQuery(
        '''
        SELECT COUNT(*) 
        FROM attendance 
        WHERE course_id = ? 
        AND date LIKE ? 
        AND status IN ('Present', 'Late')
        ''',
        [courseId, '$dateStr%'],
      );

      final presentStudents = Sqflite.firstIntValue(presentResult) ?? 0;

      // 3. Calculate percentage
      final percentage = (presentStudents / totalStudents) * 100;

      return DataResponse.success(data: percentage);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }
}
