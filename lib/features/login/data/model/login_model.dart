class LoginModel {
  final String emailId;
  final String password;

  LoginModel({required this.emailId, required this.password});

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      emailId: map['email_id'] as String,
      password: map['password'] as String,
    );
  }
}
