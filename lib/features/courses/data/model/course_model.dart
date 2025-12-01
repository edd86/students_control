import 'package:students_control/features/courses/domain/entities/course.dart';

class CourseModel extends Course {
  const CourseModel({
    super.id,
    required super.teacherId,
    required super.name,
    super.code,
    super.icon,
    super.colorHex,
    super.description,
    required super.academicTerm,
    super.createdAt,
    super.updatedAt,
  });

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'],
      teacherId: map['teacher_id'],
      name: map['name'],
      code: map['code'],
      icon: map['icon'],
      colorHex: map['color'],
      description: map['description'],
      academicTerm: map['academic_term'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'teacher_id': teacherId,
      'name': name,
      'code': code,
      'icon': icon,
      'color': colorHex,
      'description': description,
      'academic_term': academicTerm,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  CourseModel copyWith({
    int? id,
    int? teacherId,
    String? name,
    String? code,
    String? icon,
    String? colorHex,
    String? description,
    String? academicTerm,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CourseModel(
      id: id ?? this.id,
      teacherId: teacherId ?? this.teacherId,
      name: name ?? this.name,
      code: code ?? this.code,
      icon: icon ?? this.icon,
      colorHex: colorHex ?? this.colorHex,
      description: description ?? this.description,
      academicTerm: academicTerm ?? this.academicTerm,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory CourseModel.fromEntity(Course course) {
    return CourseModel(
      id: course.id,
      teacherId: course.teacherId,
      name: course.name,
      code: course.code,
      icon: course.icon,
      colorHex: course.colorHex,
      description: course.description,
      academicTerm: course.academicTerm,
      createdAt: course.createdAt,
      updatedAt: course.updatedAt,
    );
  }
}
