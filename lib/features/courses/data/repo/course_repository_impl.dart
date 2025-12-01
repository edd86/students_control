import 'package:students_control/core/database/database_helper.dart';
import 'package:students_control/core/utils/data_response.dart';
import 'package:students_control/features/courses/data/mapper/course_mapper.dart';
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
  Future<DataResponse<int>> addCourse(
    Course course,
    List<Schedule> schedules,
  ) async {
    final db = await DatabaseHelper.instance.database;

    try {
      return await db.transaction((txn) async {
        final courseModel = CourseModel.fromEntity(course);
        final courseId = await txn.insert('courses', courseModel.toMap());

        for (final schedule in schedules) {
          final scheduleModel = ScheduleModel.fromEntity(schedule);
          // We need to create a map and override course_id
          final scheduleMap = scheduleModel.toMap();
          scheduleMap['course_id'] = courseId;

          await txn.insert('schedules', scheduleMap);
        }

        return DataResponse.success(
          message: 'Curso creado correctamente',
          data: courseId,
        );
      });
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }
}
