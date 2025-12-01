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
    super.group,
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
      group: map['group'],
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
      'group': group,
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
    String? group,
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
      group: group ?? this.group,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
