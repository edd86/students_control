import 'package:students_control/core/constants/attendance_status.dart';
import 'package:students_control/features/students/domain/entity/student.dart';

class EnrolledStudent {
  final Student student;
  final AttendanceStatus? status;

  EnrolledStudent({required this.student, this.status});
}
