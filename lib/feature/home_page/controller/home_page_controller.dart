import 'package:authentication_app/feature/home_page/presentation/widgets/home_page_model.dart';
import 'package:authentication_app/feature/home_page/repository/home_page_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_page_controller.g.dart';

@riverpod
class HomePage extends _$HomePage {
  @override
  FutureOr<HomeModelState?> build() {
    return null;
  }

  FutureOr<HomeModelState?> getInfo() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return HomePageRepository.getInfo();
    });
    return null;
  }
}

