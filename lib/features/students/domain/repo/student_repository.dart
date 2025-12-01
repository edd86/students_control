import 'package:students_control/core/utils/data_response.dart';
import 'package:students_control/features/students/domain/entity/student.dart';

abstract class StudentRepository {
  Future<DataResponse<List<Student>>> getAllStudents();
}
