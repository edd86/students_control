import 'package:students_control/features/courses/data/model/course_model.dart';
import 'package:students_control/features/courses/domain/entities/course.dart';

class CourseMapper {
  static Course toEntity(CourseModel model) {
    return Course(
      id: model.id,
      teacherId: model.teacherId,
      name: model.name,
      code: model.code,
      colorHex: model.colorHex,
      description: model.description,
      academicTerm: model.academicTerm,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  static CourseModel toModel(Course entity) {
    return CourseModel(
      id: entity.id,
      teacherId: entity.teacherId,
      name: entity.name,
      code: entity.code,
      colorHex: entity.colorHex,
      description: entity.description,
      academicTerm: entity.academicTerm,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
