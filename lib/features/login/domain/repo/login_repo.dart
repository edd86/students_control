import 'package:students_control/core/utils/data_response.dart';
import 'package:students_control/features/login/domain/entity/login.dart';
import 'package:students_control/features/teachers/domain/entities/teacher.dart';

abstract class LoginRepo {
  Future<DataResponse<Teacher>> login(Login login);
}
