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
      final result = await db.query('students', orderBy: 'last_name ASC');

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

  @override
  Future<DataResponse<Student>> createStudent(Student student) async {
    final db = await DatabaseHelper.instance.database;
    final studentModel = StudentMapper.toModel(student);

    try {
      final result = await db.insert('students', studentModel.toMap());
      if (result <= 0) {
        return DataResponse.error('Error al crear al Estudiante');
      }
      return DataResponse.success(
        message: 'Estudiante creado correctamente',
        data: StudentMapper.toEntity(studentModel.copyWith(id: result)),
      );
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  @override
  Future<DataResponse<List<Student>>> findStudentsByNameId(
    String nameId,
  ) async {
    final db = await DatabaseHelper.instance.database;

    try {
      final result = await db.query(
        'students',
        where:
            'first_name LIKE ? OR last_name LIKE ? OR identification_number LIKE ?',
        whereArgs: ['%$nameId%', '%$nameId%', '%$nameId%'],
      );

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
