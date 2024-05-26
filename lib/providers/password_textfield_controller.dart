
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'password_textfield_controller.g.dart';
@riverpod
class PasswordController extends _$PasswordController{
  @override
  bool build(){
    return false;
  }
  void update(){
    state = true;
  }
}
