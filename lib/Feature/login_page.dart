import 'package:device_info_plus/device_info_plus.dart';
import 'package:first_app/Feature/forget_password_page.dart';
import 'package:first_app/core/widgets/appbar_tittle.dart';
import 'package:first_app/core/gen/fonts.gen.dart';
import 'package:first_app/Feature/sign_up_page.dart';
import 'package:first_app/Feature/update_profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import '../core/navigation/routes/routes_name.dart';
import '../core/widgets/circular_tile.dart';
import '../core/widgets/button_text.dart';
import '../core/widgets/custom_password_filed.dart';
import '../core/widgets/custom_text.dart';
import '../core/widgets/custom_text_filed.dart';
import '../core/widgets/custom_welcome_text.dart';
import '../core/widgets/custom_underline.dart';
import '../providers/auth_controller.dart';
import '../providers/email_textfield_controller.dart';
import '../providers/login_button_controller.dart';
import '../providers/password_textfield_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  ({bool email, bool password}) enableButtonNotifier =
      (email: false, password: false);

  @override
  void initState() {
    super.initState();

    email.addListener(
      () {
        setState(() {
          enableButtonNotifier = (
            email: email.value.text.isNotEmpty,
            password: password.value.text.isNotEmpty
          );
        });
        print(enableButtonNotifier);
      },
    );
    password.addListener(
      () {
        setState(() {
          enableButtonNotifier = (
            email: email.value.text.isNotEmpty,
            password: password.value.text.isNotEmpty
          );
        });
        print(enableButtonNotifier);
      },
    );
  }

  bool temp = false;

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);

    ref.listen(loginProvider, (_, next) {
      if (next.value ?? false) {
        context.pushNamed(Routes.profile);
      } else if (next.hasError && !next.isLoading) {
        _buildShowDialog(context);
      }
    });

    bool loginButtonState = ref.watch(loginButtonControllerProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Stack(
            children: [AppbarTittle('Log In to Authy'), Underline(right: 77)],
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 45),
                  const CustomWelcomeText(
                      'Welcome back! Sign in using your social'),
                  const CustomWelcomeText('account or email to continue us'),
                  const SizedBox(height: 30),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularTile(imagePath: 'Assets/Images/facebook.png'),
                      SizedBox(width: 22),
                      CircularTile(imagePath: 'Assets/Images/google.png'),
                      SizedBox(width: 22),
                      CircularTile(imagePath: 'Assets/Images/apple.png'),
                    ],
                  ),
                  const SizedBox(height: 55),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            height: 1,
                            width: 150,
                            color: const Color(0xFFCDD1D0)),
                        const Text(
                          'OR',
                          style: TextStyle(
                            fontFamily: FontFamily.circular,
                            color: Color(0xFFCDD1D0),
                          ),
                        ),
                        Container(
                          height: 1,
                          width: 150,
                          color: const Color(0xFFCDD1D0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText('Email'),
                        CustomTextField(
                          controller: email,
                          hintText: 'Enter your email',
                          onChanged: (value) {
                            ref.read(emailControllerProvider.notifier).update();
                            ref
                                .read(loginButtonControllerProvider.notifier)
                                .update();
                          },
                        ),
                        const SizedBox(height: 20),
                        const CustomText('Password'),
                        CustomPasswordField(
                          controller: password,
                          hintText: 'Enter your password',
                          onChanged: (value) {
                            ref
                                .read(passwordControllerProvider.notifier)
                                .update();
                            ref
                                .read(loginButtonControllerProvider.notifier)
                                .update();
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            children: [
                              Checkbox(
                                value: false,
                                onChanged: (newValue) {},
                              ),
                              const CustomText('Remember Me'),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            GoRouter.of(context)
                                .pushNamed(Routes.forgetPassword);
                          },
                          child: const CustomText('Forget Password'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 115),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: ElevatedButton(
                      onPressed: (enableButtonNotifier.email &&
                              enableButtonNotifier.password)
                          ? () => ref.read(loginProvider.notifier).signIn(
                                email: email.text.toString(),
                                password: password.text.toString(),
                              )
                          : null,
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          (enableButtonNotifier.email &&
                                  enableButtonNotifier.password)
                              ? const Color(0xFF24786D)
                              : const Color(0xFFD0CCC1),
                        ),
                        minimumSize: const WidgetStatePropertyAll(
                            Size(double.infinity, 50)),
                      ),
                      child: loginState.isLoading
                          ? const CircularProgressIndicator(
                              backgroundColor: Colors.white)
                          : (enableButtonNotifier.email &&
                                  enableButtonNotifier.password)
                              ? const Text(
                                  'Login',
                                  style: TextStyle(color: Color(0xFFFFFFFF)),
                                )
                              : const Text(
                                  'Login',
                                  style: TextStyle(color: Color(0xFF797C7B)),
                                ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).pushNamed(Routes.signup);
                    },
                    child: const CustomText("Don't  have an account?Sign Up"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _buildShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error! Bad request.'),
          content: const Text('Invalid Email or Password'),
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
}
