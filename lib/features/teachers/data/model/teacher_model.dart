import '../../domain/entities/teacher.dart';

class TeacherModel extends Teacher {
  TeacherModel({
    super.id,
    required super.fullName,
    required super.email,
    required super.passwordHash,
    super.teacherIdentifier,
    super.profilePhoto,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    return TeacherModel(
      id: map['id'] as int?,
      fullName: map['full_name'] as String,
      email: map['email'] as String,
      passwordHash: map['password_hash'] as String,
      teacherIdentifier: map['teacher_identifier'] as String?,
      profilePhoto: map['profile_photo'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
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
