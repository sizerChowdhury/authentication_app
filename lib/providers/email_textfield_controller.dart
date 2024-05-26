import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'email_textfield_controller.g.dart';
@riverpod
class EmailController extends _$EmailController{
  @override
  bool build(){
    return false;
  }
  void update(){
    state = true;
  }
}