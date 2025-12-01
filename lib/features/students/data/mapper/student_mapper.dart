import 'package:students_control/features/students/data/models/student_model.dart';
import 'package:students_control/features/students/domain/entity/student.dart';

class StudentMapper {
  static StudentModel toModel(Student student) {
    return StudentModel(
      id: student.id,
      firstName: student.firstName,
      lastName: student.lastName,
      identificationNumber: student.identificationNumber,
      email: student.email,
      phone: student.phone,
      gradeLevel: student.gradeLevel,
      notes: student.notes,
      profilePhoto: student.profilePhoto,
      createdAt: student.createdAt,
      updatedAt: student.updatedAt,
    );
  }

  static Student toEntity(StudentModel studentModel) {
    return Student(
      id: studentModel.id,
      firstName: studentModel.firstName,
      lastName: studentModel.lastName,
      identificationNumber: studentModel.identificationNumber,
      email: studentModel.email,
      phone: studentModel.phone,
      gradeLevel: studentModel.gradeLevel,
      notes: studentModel.notes,
      profilePhoto: studentModel.profilePhoto,
      createdAt: studentModel.createdAt,
      updatedAt: studentModel.updatedAt,
    );
  }
}
