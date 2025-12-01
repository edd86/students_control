import 'package:students_control/core/utils/data_response.dart';
import 'package:students_control/features/teachers/domain/entities/teacher.dart';

abstract class TeacherRepository {
  Future<DataResponse<Teacher>> registerTeacher(Teacher teacher);
}
