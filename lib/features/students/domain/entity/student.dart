class Student {
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

  Student({
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
}
