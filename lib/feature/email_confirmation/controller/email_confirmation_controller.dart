import 'package:authentication_app/feature/email_confirmation/repository/email_confirmation_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'email_confirmation_controller.g.dart';
@riverpod
class EmailConfirmation extends _$EmailConfirmation {
  @override
  FutureOr<bool?> build() async {
    return null;
  }

  void otpConfirmation({required String email,required String otp})
  async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return EmailConfirmationRepository().EmailConfirmation(email, otp);
    });
  }
}