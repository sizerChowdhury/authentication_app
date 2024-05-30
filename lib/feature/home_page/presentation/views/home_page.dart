import 'package:authentication_app/core/gen/assets.gen.dart';
import 'package:authentication_app/core/widgets/title_underline.dart';
import 'package:authentication_app/feature/home_page/controller/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
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

    return Scaffold(
      appBar: AppBar(
        title:
        Stack(
          children: [
            Text('HomePage',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Underline(right: 50)
          ],
        ),
        centerTitle: true,
      ),
      body: homePageState.isLoading?const CircularProgressIndicator(
          backgroundColor: Colors.white,):Center(
        child: Column(
          children: [
            const SizedBox(height: 30,),
            Stack(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color:
                    Color(0xFFFFC746), // Set your desired color here
                    shape: BoxShape.circle,
                  ),
                ),
                Image(
                  image: Assets.assets.images.profile.provider(),
                  height: 75,
                  width: 80, // Using the image provider
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Color(
                          0xFF24786D), // Set your desired color here
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
            const SizedBox(height: 40,),
               FutureBuilder<List<String>>(
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
                        _buildRow("Firstname:", names[0]),
                        _buildRow("Lastname:", names[1]),
                        _buildRow("Email:", names[2]),
                      ],
                    );
                  }
                },
                             ),
          ],
        ),
      )
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


