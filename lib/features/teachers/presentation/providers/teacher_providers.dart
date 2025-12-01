import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:students_control/features/login/data/services/password_hasher_impl.dart';
import 'package:students_control/features/login/domain/services/password_hasher.dart';
import 'package:students_control/features/teachers/data/repo/teacher_repository_impl.dart';
import 'package:students_control/features/teachers/domain/repo/teacher_repository.dart';

final teacherRepositoryProvider = Provider<TeacherRepository>((ref) {
  return TeacherRepositoryImpl();
});

final passwordHasherProvider = Provider<PasswordHasher>((ref) {
  return PasswordHasherImpl();
});
