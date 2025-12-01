import 'package:students_control/core/database/database_helper.dart';
import 'package:students_control/core/utils/data_response.dart';
import 'package:students_control/features/login/data/services/password_hasher_impl.dart';
import 'package:students_control/features/login/domain/entity/login.dart';
import 'package:students_control/features/login/domain/repo/login_repo.dart';
import 'package:students_control/features/teachers/data/model/teacher_model.dart';
import 'package:students_control/features/teachers/domain/entities/teacher.dart';

class LoginRepoImpl implements LoginRepo {
  @override
  Future<DataResponse<Teacher>> login(Login login) async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query(
      'teachers',
      where: 'email = ? OR teacher_identifier = ?',
      whereArgs: [login.emailId],
    );

    if (result.isEmpty) {
      return DataResponse.error('Usuario no encontrado');
    }

    final teacher = TeacherModel.fromMap(result.first);
    if (PasswordHasherImpl().checkPassword(
      login.password,
      teacher.passwordHash,
    )) {
      return DataResponse.success(message: 'Login exitoso', data: teacher);
    } else {
      return DataResponse.error('Contraseña incorrecta');
    }
  }
}
