import 'package:students_control/core/utils/data_response.dart';
import 'package:students_control/features/enrollments/domain/entities/enrolled_student.dart';

abstract class EnrollmentRepo {
  Future<DataResponse<int>> getContStudentEnrollments(int courseId);
  Future<DataResponse<List<EnrolledStudent>>> getEnrolledStudentsWithStatus(
    int courseId,
    DateTime date,
  );
}
