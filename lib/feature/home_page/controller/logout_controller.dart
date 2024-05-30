import 'package:authentication_app/feature/home_page/repository/logout_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'logout_controller.g.dart';
@riverpod
class LogoutController extends _$LogoutController {
  @override
  FutureOr<bool?> build() {
    return null;
  }
  void signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return LogoutRepository.signOut();
    });
  }
}