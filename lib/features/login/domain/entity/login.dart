class Login {
  final String emailId;
  final String? teacherIdentifier;
  final String password;

  Login({
    required this.emailId,
    this.teacherIdentifier,
    required this.password,
  });
}
