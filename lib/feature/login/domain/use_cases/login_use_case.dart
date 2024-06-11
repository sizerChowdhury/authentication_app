
import 'package:authentication_app/feature/login/data/repositories/login_repository_imp.dart';
import 'package:authentication_app/feature/login/domain/entities/login_entity.dart';
import 'package:authentication_app/feature/login/domain/repositories/login_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_use_case.g.dart';

@riverpod
LoginUseCase loginUseCase(LoginUseCaseRef ref) {
  final loginImp = ref.read(loginRepositoryProvider);
  return LoginUseCase(loginRepo: loginImp);
}

class LoginUseCase {
  final LoginRepository loginRepo;

  LoginUseCase({required this.loginRepo});

  FutureOr<LoginEntity?> userLogin({
    required String email,
    required String password,
    required isLogin,
  }) async {
    LoginEntity? abc = await loginRepo.getUserLogin(
      email: email,
      password: password,
      isLogin: isLogin,
    );
    return abc;
  }
}