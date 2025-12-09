import 'package:students_control/core/constants/attendance_status.dart';
import 'package:students_control/core/database/database_helper.dart';
import 'package:students_control/core/utils/data_response.dart';
import 'package:students_control/features/enrollments/domain/entities/enrolled_student.dart';
import 'package:students_control/features/enrollments/domain/repo/enrollment_repo.dart';
import 'package:students_control/features/students/data/mapper/student_mapper.dart';
import 'package:students_control/features/students/data/models/student_model.dart';

class EnrollmentRepoImpl implements EnrollmentRepo {
  @override
  Future<DataResponse<int>> getContStudentEnrollments(int courseId) async {
    final db = await DatabaseHelper.instance.database;

    try {
      final result = await db.query(
        'enrollments',
        where: 'course_id = ?',
        whereArgs: [courseId],
      );

      if (result.isEmpty) {
        return DataResponse.success(data: 0);
      }
      return DataResponse.success(data: result.length);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  @override
  Future<DataResponse<List<EnrolledStudent>>> getEnrolledStudentsWithStatus(
    int courseId,
    DateTime date,
  ) async {
    final db = await DatabaseHelper.instance.database;

    try {
      final dateStr = date.toIso8601String().split('T').first;

      // We need to fetch students enrolled in the course
      // and their attendance status for the specific date
      final result = await db.rawQuery(
        '''
        SELECT s.*, a.status as attendance_status
        FROM enrollments e
        JOIN students s ON e.student_id = s.id
        LEFT JOIN attendance a ON a.student_id = s.id 
          AND a.course_id = e.course_id 
          AND a.date LIKE ?
        WHERE e.course_id = ?
        ORDER BY s.last_name, s.first_name
        ''',
        ['$dateStr%', courseId],
      );

      final enrolledStudents = result.map((row) {
        final studentModel = StudentModel.fromMap(row);
        final student = StudentMapper.toEntity(studentModel);

        AttendanceStatus? status;
        if (row['attendance_status'] != null) {
          final statusStr = row['attendance_status'] as String;
          try {
            status = AttendanceStatus.values.firstWhere(
              (e) =>
                  e.name.toLowerCase() == statusStr.toLowerCase() ||
                  e.label.toLowerCase() == statusStr.toLowerCase(),
              orElse: () =>
                  AttendanceStatus.presente, // Fallback if needed, or null
            );
          } catch (_) {
            // Status might not match enum exactly if DB had different values
          }
        }

        return EnrolledStudent(student: student, status: status);
      }).toList();

      return DataResponse.success(data: enrolledStudents);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }
}
