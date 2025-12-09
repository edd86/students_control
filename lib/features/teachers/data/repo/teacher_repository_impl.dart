import 'package:students_control/core/database/database_helper.dart';
import 'package:students_control/core/utils/data_response.dart';
import 'package:students_control/features/teachers/data/mapper/teacher_mapper.dart';
import 'package:students_control/features/teachers/domain/entities/teacher.dart';
import 'package:students_control/features/teachers/domain/repo/teacher_repository.dart';

class TeacherRepositoryImpl implements TeacherRepository {
  @override
  Future<DataResponse<Teacher>> registerTeacher(Teacher teacher) async {
    final db = await DatabaseHelper.instance.database;
    final teacherModel = TeacherMapper.toModel(teacher);

    try {
      final result = await db.insert('teachers', teacherModel.toMap());
      if (result <= 0) {
        return DataResponse.error('Error al registrar el docente');
      }
      return DataResponse.success(
        message: 'Docente registrado exitosamente',
        data: TeacherMapper.toEntity(teacherModel),
      );
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }
}
