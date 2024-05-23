import 'package:flutter/material.dart';
import 'core/navigation/router_config/router_config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: MyRouterConfig().router,
    );
  }
}
