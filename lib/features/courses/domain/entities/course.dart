class Course {
  final int? id;
  final int teacherId;
  final String name;
  final String? code;
  final String? icon;
  final String? colorHex;
  final String? description;
  final String? academicTerm;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Course({
    this.id,
    required this.teacherId,
    required this.name,
    this.code,
    this.icon,
    this.colorHex,
    this.description,
    this.academicTerm,
    this.createdAt,
    this.updatedAt,
  });
}
