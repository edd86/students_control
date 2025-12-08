import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:students_control/features/login/data/repo/login_repo_impl.dart';
import 'package:students_control/features/login/domain/entity/login.dart';
import 'package:students_control/features/login/domain/repo/login_repo.dart';
import 'package:students_control/features/teachers/domain/entities/teacher.dart';

class LoginPasswordVisibilityNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}

final loginPasswordVisibilityProvider =
    NotifierProvider<LoginPasswordVisibilityNotifier, bool>(
      LoginPasswordVisibilityNotifier.new,
    );

// Repository Provider
final loginRepoProvider = Provider<LoginRepo>((ref) {
  return LoginRepoImpl();
});

// Current User Notifier
class CurrentUserNotifier extends Notifier<Teacher?> {
  @override
  Teacher? build() {
    return null;
  }

  void setUser(Teacher? teacher) {
    state = teacher;
  }
}

final currentUserProvider = NotifierProvider<CurrentUserNotifier, Teacher?>(
  CurrentUserNotifier.new,
);

// Login Controller
class LoginController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // Initial state is void (data: null)
    return null;
  }

  Future<bool> login(
    String email,
    String password,
    String teacherIdentifier,
  ) async {
    state = const AsyncValue.loading();

    final repo = ref.read(loginRepoProvider);
    final loginData = Login(
      emailId: email,
      password: password,
      teacherIdentifier: teacherIdentifier,
    );

    // Guard against async gaps if needed, but here we just await
    final result = await repo.login(loginData);

    if (result.isSuccess) {
      ref.read(currentUserProvider.notifier).setUser(result.data);
      state = const AsyncValue.data(null);
      return true;
    } else {
      state = AsyncValue.error(
        result.message ?? 'Error desconocido',
        StackTrace.current,
      );
      return false;
    }
  }
}

final loginControllerProvider = AsyncNotifierProvider<LoginController, void>(
  LoginController.new,
);
