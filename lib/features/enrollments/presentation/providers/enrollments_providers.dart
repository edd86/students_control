import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:students_control/features/enrollments/domain/entities/enrolled_student.dart';
import 'package:students_control/features/enrollments/data/repo/enrollment_repo_impl.dart';
import 'package:students_control/features/enrollments/domain/repo/enrollment_repo.dart';

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
