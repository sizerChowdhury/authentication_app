import 'package:authentication_app/feature/login/presentation/widgets/login_model.dart';
import 'package:authentication_app/feature/login/repository/login_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_controller.g.dart';

@riverpod
class Login extends _$Login {
  @override
  FutureOr<LoginModelState?> build() {
    return null;
  }

  void signIn({required String email, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return LoginRepository.logIn(email: email, password: password);
    });
  }
}
