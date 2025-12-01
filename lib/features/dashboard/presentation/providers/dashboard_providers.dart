import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:students_control/features/courses/data/repo/course_repository_impl.dart';
import 'package:students_control/features/students/data/repo/student_repository_impl.dart';

final dashboardIndexProvider = StateProvider<int>((ref) => 0);

final totalCoursesProvider = FutureProvider<int>((ref) async {
  final courseRepository = CourseRepositoryImpl();
  final courses = await courseRepository.getAllCourses();
  return courses.data?.length ?? 0;
});

final totalStudentsProvider = FutureProvider<int>((ref) async {
  final studentRepository = StudentRepositoryImpl();
  final students = await studentRepository.getAllStudents();
  return students.data?.length ?? 0;
});
