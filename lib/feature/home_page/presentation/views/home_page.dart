import 'package:authentication_app/core/gen/assets.gen.dart';
import 'package:authentication_app/core/widgets/title_underline.dart';
import 'package:authentication_app/feature/home_page/controller/home_page_controller.dart';
import 'package:authentication_app/feature/home_page/controller/logout_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool flag = true;

  @override
  void initState() {
    super.initState();
    Future(() {
      ref.read(homePageProvider.notifier).getInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homePageProvider);
    final logoutState = ref.watch(logoutControllerProvider);

    ref.listen(homePageProvider, (_, next) {
      if (!next.isLoading) {
        setState(() {
          flag = false;
        });
      }
    });

    ref.listen(logoutControllerProvider, (_, next) {
      if (next.value ?? false) {
        context.go('/');
      } else if (next.hasError && !next.isLoading) {
        print('logout failed');
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/');
          },
        ),
        title: Stack(
          children: [
            Text(
              'Home Page',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Underline(right: 50),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Stack(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFC746),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Image(
                    image: Assets.assets.images.profile.provider(),
                    height: 75,
                    width: 80,
                  ),
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (flag)
                      ? const CircularProgressIndicator()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Name: ${state.value?.getFirstName()}'
                              ' ${state.value?.getLastName()}',
                            ),
                            Text(
                              'Email: ${state.value?.getEmail()}',
                            ),
                          ],
                        ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: ref.read(logoutControllerProvider.notifier).getInfo,
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Theme.of(context).colorScheme.primary),
                child: logoutState.isLoading
                    ? const CircularProgressIndicator(
                  backgroundColor: Colors.white,
                )
                    : Text(
                  'Logout',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
              const SizedBox(height: 37),
            ],
          ),
        ),
      ),
    );
  }
}
