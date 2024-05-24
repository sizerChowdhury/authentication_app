import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/navigation/router_config/router_config.dart';

void main() {
  // wrap the entire app with a ProviderScope so that widgets
  // will be able to read providers
  runApp(MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        routerConfig: MyRouterConfig().router,
      ),
    );
  }
}
