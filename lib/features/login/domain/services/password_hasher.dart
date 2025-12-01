abstract class PasswordHasher {
  String hashPassword(String password);
  bool checkPassword(String password, String hash);
}
