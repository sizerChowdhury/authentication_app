import 'package:authentication_app/feature/reset_password/repository/reset_password_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reset_password_controller.g.dart';

@riverpod
class ResetPassword extends _$ResetPassword {
  @override
  FutureOr<bool?> build() async {
    return null;
  }

  void resetPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return ResetPasswordRepository()
          .resetPassword(email, password, confirmPassword);
    });
  }
}
