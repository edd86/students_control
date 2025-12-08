import '../../domain/entities/teacher.dart';
import '../model/teacher_model.dart';

class TeacherMapper {
  static Teacher toEntity(TeacherModel model) {
    return Teacher(
      id: model.id,
      fullName: model.fullName,
      email: model.email,
      passwordHash: model.passwordHash,
      teacherIdentifier: model.teacherIdentifier,
      profilePhoto: model.profilePhoto,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  static TeacherModel toModel(Teacher entity) {
    return TeacherModel(
      id: entity.id,
      fullName: entity.fullName,
      email: entity.email,
      passwordHash: entity.passwordHash,
      teacherIdentifier: entity.teacherIdentifier,
      profilePhoto: entity.profilePhoto,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
