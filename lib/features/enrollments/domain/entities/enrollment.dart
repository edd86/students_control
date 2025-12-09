class Enrollment {
  final int id;
  final int courseId;
  final int studentId;
  final int scheduleId;
  final DateTime enrolledAt;

  const Enrollment({
    required this.id,
    required this.courseId,
    required this.studentId,
    required this.scheduleId,
    required this.enrolledAt,
  });
}
