import 'package:authentication_app/feature/forget_password/repository/forget_password_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'forget_password_controller.g.dart';

@riverpod
class ForgetPassword extends _$ForgetPassword {
  @override
  FutureOr<bool?> build() async {
    return null;
  }

  void otpConfirmation({required String email}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return ForgetPasswordRepository().forgetPassword(email);
    });
  }
}
