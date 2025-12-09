class EnrollmentModel {
  final int id;
  final int courseId;
  final int studentId;
  final int scheduleId;
  final DateTime enrolledAt;

  const EnrollmentModel({
    required this.id,
    required this.courseId,
    required this.studentId,
    required this.scheduleId,
    required this.enrolledAt,
  });

  factory EnrollmentModel.fromMap(Map<String, dynamic> map) {
    return EnrollmentModel(
      id: map['id'],
      courseId: map['course_id'],
      studentId: map['student_id'],
      scheduleId: map['schedule_id'],
      enrolledAt: DateTime.parse(map['enrolled_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'course_id': courseId,
      'student_id': studentId,
      'schedule_id': scheduleId,
      'enrolled_at': enrolledAt.toIso8601String(),
    };
  }

  EnrollmentModel copyWith({
    int? id,
    int? courseId,
    int? studentId,
    int? scheduleId,
    DateTime? enrolledAt,
  }) {
    return EnrollmentModel(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      studentId: studentId ?? this.studentId,
      scheduleId: scheduleId ?? this.scheduleId,
      enrolledAt: enrolledAt ?? this.enrolledAt,
    );
  }
}
