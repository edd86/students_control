class LoginModel {
  final String emailId;
  final String? teacherIdentifier;
  final String password;

  LoginModel({
    required this.emailId,
    this.teacherIdentifier,
    required this.password,
  });

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      emailId: map['email_id'],
      teacherIdentifier: map['teacher_identifier'],
      password: map['password'],
    );
  }
}
