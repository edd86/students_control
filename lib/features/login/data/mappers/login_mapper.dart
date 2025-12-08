import 'package:students_control/features/login/data/model/login_model.dart';
import 'package:students_control/features/login/domain/entity/login.dart';

class LoginMapper {
  static Login toEntity(LoginModel model) {
    return Login(
      emailId: model.emailId,
      teacherIdentifier: model.teacherIdentifier,
      password: model.password,
    );
  }

  static LoginModel toModel(Login entity) {
    return LoginModel(
      emailId: entity.emailId,
      teacherIdentifier: entity.teacherIdentifier,
      password: entity.password,
    );
  }
}
