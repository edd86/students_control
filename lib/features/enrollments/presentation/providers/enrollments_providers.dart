import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:students_control/features/enrollments/domain/entities/enrolled_student.dart';
import 'package:students_control/features/enrollments/data/repo/enrollment_repo_impl.dart';
import 'package:students_control/features/enrollments/domain/repo/enrollment_repo.dart';
import 'package:students_control/features/students/domain/entity/student.dart';
import 'dart:async';

final enrollmentRepoProvider = Provider<EnrollmentRepo>((ref) {
  return EnrollmentRepoImpl();
});

final studentCountProvider = FutureProvider.family<int, int>((
  ref,
  courseId,
) async {
  final repo = ref.watch(enrollmentRepoProvider);
  final response = await repo.getContStudentEnrollments(courseId);
  return response.data ?? 0;
});

final enrolledStudentsProvider =
    FutureProvider.family<List<EnrolledStudent>, int>((ref, courseId) async {
      final repo = ref.watch(enrollmentRepoProvider);
      final response = await repo.getEnrolledStudentsWithStatus(
        courseId,
        DateTime.now(),
      );

      if (response.data == null) {
        throw Exception(response.message);
      }

      return response.data!;
    });

final availableStudentsProvider = FutureProvider.family
    .autoDispose<List<Student>, int>((ref, courseId) async {
      final repo = ref.watch(enrollmentRepoProvider);
      final response = await repo.getAvailableStudentsForCourse(courseId);

      if (response.data == null) {
        throw Exception(response.message);
      }

      return response.data!;
    });

final enrollmentControllerProvider =
    AsyncNotifierProvider<EnrollmentController, void>(EnrollmentController.new);

class EnrollmentController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<void> enrollStudents(int courseId, List<int> studentIds) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(enrollmentRepoProvider);
      final result = await repo.enrollStudents(courseId, studentIds);

      if (!result.isSuccess) {
        throw Exception(result.message ?? 'Error al matricular');
      }

      ref.invalidate(availableStudentsProvider(courseId));
      ref.invalidate(studentCountProvider(courseId));
      ref.invalidate(enrolledStudentsProvider(courseId));
    });
  }
}
