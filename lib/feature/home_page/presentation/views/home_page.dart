import 'package:authentication_app/core/gen/assets.gen.dart';
import 'package:authentication_app/core/widgets/title_underline.dart';
import 'package:authentication_app/feature/home_page/controller/home_page_controller.dart';
import 'package:authentication_app/feature/home_page/controller/logout_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    Future(() {
      ref.read(homePageProvider.notifier).homePageApiCall();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homePageState = ref.watch(homePageProvider);
    final logoutState = ref.watch(logoutControllerProvider);

    ref.listen(logoutControllerProvider, (_, next) {
      if (next.value ?? false) {
        context.go('/');
      } else if (next.hasError && !next.isLoading) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error! Bad request.'),
              content: const Text('Logout failed'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
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
      body: homePageState.isLoading
          ? const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            )
          : Column(
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
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(100, 20, 20, 0),
                  child: FutureBuilder<List<String>>(
                    future: _getFirstNameFromCache(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final names = snapshot.data ?? [];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildRow("Name:", "${names[0]} ${names[1]}"),
                            _buildRow("Email:", names[2]),
                          ],
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 320,
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(logoutControllerProvider.notifier).signOut();
                  },
                  child: (logoutState.isLoading)
                      ? const CircularProgressIndicator()
                      : const Text('Logout'),
                ),
              ],
            ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }

  Future<List<String>> _getFirstNameFromCache() async {
    List<String> item = [];
    final prefs = await SharedPreferences.getInstance();
    item.add(prefs.getString('firstname') ?? '');
    item.add(prefs.getString('lastname') ?? '');
    item.add(prefs.getString('email') ?? '');
    return item;
  }
}
