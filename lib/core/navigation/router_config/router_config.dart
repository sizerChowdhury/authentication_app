import 'package:authentication_app/core/navigation/routes/routes_name.dart';
import 'package:authentication_app/feature/login/presentation/pages/login_page.dart';
import 'package:authentication_app/feature/signup/presentation/views/sign_up_page.dart';
import 'package:authentication_app/feature/home_page/presentation/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:authentication_app/feature/email_confirmation/presentation/views/email_confirmation_page.dart';
import 'package:authentication_app/feature/forget_password/presentation/views/forget_password_page.dart';
import 'package:authentication_app/feature/reset_password/presentation/views/reset_password_page.dart';

class MyRouterConfig {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: Routes.login,
        pageBuilder: (context, state) {
          return const MaterialPage(child: LoginPage());
        },
      ),
      GoRoute(
        path: Routes.signup,
        pageBuilder: (context, state) {
          return const MaterialPage(child: SignUpPage());
        },
      ),
      GoRoute(
        path: Routes.forgetPassword,
        pageBuilder: (context, state) {
          return const MaterialPage(child: ForgetPasswordPage());
        },
      ),
      GoRoute(
        path: Routes.resetPassword,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: ResetPasswordPage(
              email: state.pathParameters['email']!,
            ),
          );
        },
      ),
      GoRoute(
        path: Routes.emailConfirmation,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: EmailConfirmationPage(
              email: state.pathParameters['email']!,
              pageSelector: state.pathParameters['pageSelector']!,
            ),
          );
        },
      ),
      GoRoute(
        path: Routes.home,
        pageBuilder: (context, state) {
          return const MaterialPage(child: HomePage());
        },
      ),
    ],
  );
}
