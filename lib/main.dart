import 'package:flutter/material.dart';
import 'core/navigation/router_config/router_config.dart';
import 'package:go_router/go_router.dart';
import 'Feature/login_page.dart';
import 'Feature/sign_up_page.dart';
import 'Feature/forget_password_page.dart';
import 'Feature/reset_password_page.dart';
import 'Feature/change_password_page.dart';
import 'Feature/email_confirmation_page.dart';
import 'Feature/update_profile_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

// final GoRouter _router = GoRouter(routes: [
//   GoRoute(path: "/", builder: (context, state) => LogIn()),
//   GoRoute(path: "/signUp", builder: (context, state) => SignUp()),
//   GoRoute(
//       path: "/forgetPassword", builder: (context, state) => ForgetPassword()),
//   GoRoute(
//       path: "/resetPassword/:email",
//       builder: (context, state) =>
//           ResetPassword(email: state.pathParameters["email"]!)),
//   GoRoute(
//       path: "/changePassword",
//       builder: (context, state) => const ChangePassword()),
//   GoRoute(
//       path: "/emailConfirmation/:email/:pageSelector",
//       builder: (context, state) => EmailConfirmation(
//           email: state.pathParameters["email"]!,
//           pageSelector: state.pathParameters["pageSelector"]!)),
//   GoRoute(
//       path: "/updateProfile",
//       builder: (context, state) => const UpdateProfile()),
// ]);
