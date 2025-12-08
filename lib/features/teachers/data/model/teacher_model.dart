class TeacherModel {
  final int? id;
  final String fullName;
  final String email;
  final String passwordHash;
  final String? teacherIdentifier;
  final String? profilePhoto;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TeacherModel({
    this.id,
    required this.fullName,
    required this.email,
    required this.passwordHash,
    this.teacherIdentifier,
    this.profilePhoto,
    this.createdAt,
    this.updatedAt,
  });

  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    return TeacherModel(
      id: map['id'],
      fullName: map['full_name'],
      email: map['email'],
      passwordHash: map['password_hash'],
      teacherIdentifier: map['teacher_identifier'],
      profilePhoto: map['profile_photo'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'password_hash': passwordHash,
      'teacher_identifier': teacherIdentifier,
      'profile_photo': profilePhoto,
      'created_at': createdAt != null
          ? createdAt!.toIso8601String()
          : DateTime.now().toIso8601String(),
      'updated_at': updatedAt != null
          ? updatedAt!.toIso8601String()
          : DateTime.now().toIso8601String(),
    };
  }

  TeacherModel copyWith({
    int? id,
    String? fullName,
    String? email,
    String? passwordHash,
    String? teacherIdentifier,
    String? profilePhoto,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TeacherModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      teacherIdentifier: teacherIdentifier ?? this.teacherIdentifier,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
