class Teacher {
  final int? id;
  final String fullName;
  final String email;
  final String passwordHash;
  final String? teacherIdentifier;
  final String? profilePhoto;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Teacher({
    this.id,
    required this.fullName,
    required this.email,
    required this.passwordHash,
    this.teacherIdentifier,
    this.profilePhoto,
    this.createdAt,
    this.updatedAt,
  });
}
