import 'package:students_control/features/students/domain/entity/student.dart';

class StudentModel extends Student {
  StudentModel({
    super.id,
    required super.firstName,
    required super.lastName,
    super.identificationNumber,
    super.email,
    super.phone,
    super.gradeLevel,
    super.notes,
    super.profilePhoto,
    required super.createdAt,
    required super.updatedAt,
  });

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      id: map['id']?.toInt(),
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      identificationNumber: map['identification_number'],
      email: map['email'],
      phone: map['phone'],
      gradeLevel: map['grade_level'],
      notes: map['notes'],
      profilePhoto: map['profile_photo'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'identification_number': identificationNumber,
      'email': email,
      'phone': phone,
      'grade_level': gradeLevel,
      'notes': notes,
      'profile_photo': profilePhoto,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  StudentModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? identificationNumber,
    String? email,
    String? phone,
    String? gradeLevel,
    String? notes,
    String? profilePhoto,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StudentModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      identificationNumber: identificationNumber ?? this.identificationNumber,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gradeLevel: gradeLevel ?? this.gradeLevel,
      notes: notes ?? this.notes,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
