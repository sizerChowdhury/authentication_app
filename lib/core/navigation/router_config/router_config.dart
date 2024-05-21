import 'package:go_router/go_router.dart';
import '../../../Feature/change_password_page.dart';
import '../../../Feature/email_confirmation_page.dart';
import '../../../Feature/forget_password_page.dart';
import '../../../Feature/login_page.dart';
import '../../../Feature/reset_password_page.dart';
import '../../../Feature/sign_up_page.dart';
import '../../../Feature/update_profile_page.dart';
import '../routes/routes_name.dart';
class MyRouterConfig{
  GoRouter router = GoRouter(routes: [
    GoRoute(
        name: Routes.login,
        path: "/", builder: (context, state) => LogIn()),
    GoRoute(
        name: Routes.signup,
        path: "/signUp", builder: (context, state) => SignUp()),
    GoRoute(
        name: Routes.forgetPassword,
        path: "/forgetPassword", builder: (context, state) => ForgetPassword()),
    GoRoute(
        name: Routes.resetPassword,
        path: "/resetPassword/:email",
        builder: (context, state) =>
            ResetPassword(email: state.pathParameters["email"]!)),
    GoRoute(
        path: "/changePassword",
        builder: (context, state) => const ChangePassword()),
    GoRoute(
        name: Routes.emailConfirmation,
        path: "/emailConfirmation/:email/:pageSelector",
        builder: (context, state) => EmailConfirmation(
            email: state.pathParameters["email"]!,
            pageSelector: state.pathParameters["pageSelector"]!)),
    GoRoute(
        name: Routes.profile,
        path: "/updateProfile",
        builder: (context, state) => const UpdateProfile()),
  ]);

}