import 'package:students_control/core/database/database_helper.dart';
import 'package:students_control/core/utils/data_response.dart';
import 'package:students_control/features/students/data/mapper/student_mapper.dart';
import 'package:students_control/features/students/data/models/student_model.dart';
import 'package:students_control/features/students/domain/entity/student.dart';
import 'package:students_control/features/students/domain/repo/student_repository.dart';

class StudentRepositoryImpl implements StudentRepository {
  @override
  Future<DataResponse<List<Student>>> getAllStudents() async {
    final db = await DatabaseHelper.instance.database;

    try {
      final result = await db.query('students');

      if (result.isEmpty) {
        return DataResponse.success(
          message: 'No hay estudiantes registrados',
          data: [],
        );
      }

      return DataResponse.success(
        message: 'Estudiantes obtenidos correctamente',
        data: result
            .map(
              (studentMap) =>
                  StudentMapper.toEntity(StudentModel.fromMap(studentMap)),
            )
            .toList(),
      );
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }
}
