import 'package:bcrypt/bcrypt.dart';
import '../../domain/services/password_hasher.dart';

class PasswordHasherImpl implements PasswordHasher {
  @override
  String hashPassword(String password) {
    final String salt = BCrypt.gensalt();
    return BCrypt.hashpw(password, salt);
  }

  @override
  bool checkPassword(String password, String hash) {
    return BCrypt.checkpw(password, hash);
  }
}
