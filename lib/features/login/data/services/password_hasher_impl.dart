import 'package:bcrypt/bcrypt.dart';
import '../../domain/services/password_hasher.dart';

class PasswordHasherImpl implements PasswordHasher {
  @override
  String hashPassword(String password) {
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }

  @override
  bool checkPassword(String password, String hash) {
    return BCrypt.checkpw(password, hash);
  }
}
