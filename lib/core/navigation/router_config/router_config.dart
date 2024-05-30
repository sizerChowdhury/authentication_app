import 'package:authentication_app/core/navigation/routes/routes_name.dart';
import 'package:authentication_app/feature/login/presentation/views/login_page.dart';
import 'package:authentication_app/feature/signup/presentation/views/sign_up_page.dart';
import 'package:authentication_app/feature/home_page/presentation/views/home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:authentication_app/feature/email_confirmation/presentation/views/email_confirmation_page.dart';
import 'package:authentication_app/feature/forget_password/presentation/views/forget_password_page.dart';
import 'package:authentication_app/feature/reset_password/presentation/views/reset_password_page.dart';

class MyRouterConfig {
  static GoRouter router = GoRouter(routes: [
    GoRoute(
      name: Routes.login,
      path: "/",
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: Routes.signup,
      path: "/signUp",
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      name: Routes.forgetPassword,
      path: "/forgetPassword",
      builder: (context, state) => const ForgetPasswordPage(),
    ),
    GoRoute(
      name: Routes.resetPassword,
      path: "/resetPassword/:email",
      builder: (context, state) => ResetPasswordPage(
          email: state.pathParameters["email"]!,
      ),
    ),
    GoRoute(
      name: Routes.emailConfirmation,
      path: "/emailConfirmation/:email/:pageSelector",
      builder: (context, state) => EmailConfirmationPage(
        email: state.pathParameters["email"]!,
        pageSelector: state.pathParameters["pageSelector"]!,
      ),
    ),
    GoRoute(
      name: Routes.home,
      path: "/homePage",
      builder: (context, state) => const HomePage(),
    ),
  ],);
}
