import 'package:authentication_app/feature/email_confirmation/repository/resend_otp_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'resend_otp_controller.g.dart';

@riverpod
class ResendOtpController extends _$ResendOtpController {
  @override
  FutureOr<bool?> build() async {
    return null;
  }

  void otpConfirmation({required String email}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return ResendOtpRepository().resendOtp(email: email);
    });
  }
}
