class StudentModel {
  final int? id;
  final String firstName;
  final String lastName;
  final String? identificationNumber;
  final String? email;
  final String? phone;
  final String? gradeLevel;
  final String? notes;
  final String? profilePhoto;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  StudentModel({
    this.id,
    required this.firstName,
    required this.lastName,
    this.identificationNumber,
    this.email,
    this.phone,
    this.gradeLevel,
    this.notes,
    this.profilePhoto,
    this.createdAt,
    this.updatedAt,
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
      'created_at': createdAt == null
          ? DateTime.now()
          : createdAt!.toIso8601String(),
      'updated_at': updatedAt == null
          ? DateTime.now()
          : updatedAt!.toIso8601String(),
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
