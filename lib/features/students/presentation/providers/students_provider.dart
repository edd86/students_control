import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:students_control/features/students/data/repo/student_repository_impl.dart';
import 'package:students_control/features/students/domain/entity/student.dart';
import 'package:students_control/features/students/domain/repo/student_repository.dart';

final studentRepositoryProvider = Provider<StudentRepository>((ref) {
  return StudentRepositoryImpl();
});

final studentsProvider = FutureProvider.autoDispose<List<Student>>((ref) async {
  final repository = ref.watch(studentRepositoryProvider);
  final response = await repository.getAllStudents();

  if (response.data != null) {
    return response.data!;
  } else {
    throw Exception(response.message);
  }
});
