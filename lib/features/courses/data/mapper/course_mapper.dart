import 'package:students_control/features/courses/data/model/course_model.dart';
import 'package:students_control/features/courses/domain/entities/course.dart';

class CourseMapper {
  static Course toEntity(CourseModel model) {
    return Course(
      id: model.id,
      teacherId: model.teacherId,
      name: model.name,
      icon: model.icon,
      code: model.code,
      colorHex: model.colorHex,
      description: model.description,
      group: model.group,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  static CourseModel toModel(Course entity) {
    return CourseModel(
      id: entity.id,
      teacherId: entity.teacherId,
      name: entity.name,
      icon: entity.icon,
      code: entity.code,
      colorHex: entity.colorHex,
      description: entity.description,
      group: entity.group,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
