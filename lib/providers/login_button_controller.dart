
import 'package:first_app/providers/password_textfield_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'email_textfield_controller.dart';
part 'login_button_controller.g.dart';
@riverpod
class LoginButtonController extends _$LoginButtonController{
  @override
  bool build(){
    return false;
  }
  void update(){
    bool emailProvider = ref.watch(emailControllerProvider);
    bool passwordProvider = ref.watch(passwordControllerProvider);
    state = (emailProvider & passwordProvider);
  }
}