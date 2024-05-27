import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'otp_field_controller.g.dart';
@riverpod
class OtpController extends _$OtpController{
  @override
  bool build(){
    return false;
  }
  void update(){
    state = true;
  }
}