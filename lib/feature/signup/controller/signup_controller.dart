import 'package:authentication_app/feature/signup/repository/signup_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signup_controller.g.dart';

@riverpod
class Signup extends _$Signup {
  @override
  FutureOr<bool?> build() async {
    return null;
  }

  void signUp({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return SignupRepository().signUp(firstname, lastname, email, password);
    });
  }
}
