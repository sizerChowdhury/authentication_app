import 'package:authentication_app/core/widgets/title_underline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomePage extends ConsumerStatefulWidget {

  const HomePage(
      {super.key,});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    Text('Home Page',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Underline(right: 77)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
