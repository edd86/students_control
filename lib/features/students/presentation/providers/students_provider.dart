import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:students_control/core/utils/data_response.dart';
import 'package:students_control/features/students/data/repo/student_repository_impl.dart';
import 'package:students_control/features/students/domain/entity/student.dart';
import 'package:students_control/features/students/domain/repo/student_repository.dart';

final studentRepositoryProvider = Provider<StudentRepository>((ref) {
  return StudentRepositoryImpl();
});

final studentSearchQueryProvider = StateProvider<String>((ref) => '');

final studentsProvider = FutureProvider.autoDispose<List<Student>>((ref) async {
  final repository = ref.watch(studentRepositoryProvider);
  final searchQuery = ref.watch(studentSearchQueryProvider);

  final DataResponse<List<Student>> response;

  if (searchQuery.isEmpty) {
    response = await repository.getAllStudents();
  } else {
    response = await repository.findStudentsByNameId(searchQuery);
  }

  if (response.data != null) {
    return response.data!;
  } else {
    throw Exception(response.message);
  }
});

final studentsControllerProvider = Provider((ref) => StudentsController(ref));

class StudentsController {
  final Ref ref;

  StudentsController(this.ref);

  Future<void> createStudent({
    required Student student,
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    final repository = ref.read(studentRepositoryProvider);
    final response = await repository.createStudent(student);

    if (response.data != null) {
      ref.invalidate(studentsProvider);
      onSuccess();
    } else {
      onError(response.message ?? 'Error desconocido');
    }
  }
}
