import 'package:authentication_app/core/gen/assets.gen.dart';
import 'package:authentication_app/core/widgets/title_underline.dart';
import 'package:authentication_app/feature/home_page/controller/home_page_controller.dart';
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

    ref.listen(homePageProvider, (_, next) {
      if (!next.isLoading) {
        setState(() {
          flag = false;
        });
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
              'HomePage',
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
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Color(
                          0xFF24786D,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
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
            ],
          ),
        ),
      ),
    );
  }
}
