import 'package:authentication_app/feature/home_page/repository/home_page_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_page_controller.g.dart';

@riverpod
class HomePage extends _$HomePage {
  @override
  FutureOr<bool?> build() async {
    return null;
  }

  Future<bool?> homePageApiCall() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return HomePageRepository.homePage();
    });
    return null;
  }
}
