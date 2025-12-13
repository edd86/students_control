import 'package:students_control/core/utils/data_response.dart';
import 'package:students_control/features/enrollments/domain/entities/enrolled_student.dart';
import 'package:students_control/features/students/domain/entity/student.dart';

abstract class EnrollmentRepo {
  Future<DataResponse<int>> getContStudentEnrollments(int courseId);
  Future<DataResponse<List<EnrolledStudent>>> getEnrolledStudentsWithStatus(
    int courseId,
    DateTime date,
  );
  Future<DataResponse<List<Student>>> getAvailableStudentsForCourse(
    int courseId,
  );
  Future<DataResponse<void>> enrollStudents(int courseId, List<int> studentIds);
}
