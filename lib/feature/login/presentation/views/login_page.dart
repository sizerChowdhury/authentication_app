import 'package:authentication_app/core/gen/assets.gen.dart';
import 'package:authentication_app/core/navigation/routes/routes_name.dart';
import 'package:authentication_app/core/widgets/appbar_tittle.dart';
import 'package:authentication_app/core/gen/fonts.gen.dart';
import 'package:authentication_app/core/widgets/circular_tile.dart';
import 'package:authentication_app/core/widgets/custom_password_filed.dart';
import 'package:authentication_app/core/widgets/custom_text.dart';
import 'package:authentication_app/core/widgets/custom_text_filed.dart';
import 'package:authentication_app/core/widgets/custom_underline.dart';
import 'package:authentication_app/core/widgets/custom_welcome_text.dart';
import 'package:authentication_app/feature/login/controller/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;


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
      () => updateEnableButtonNotifier(),
    );
    password.addListener(
      () => updateEnableButtonNotifier(),
    );
  }

  void updateEnableButtonNotifier() {
    setState(() {
      enableButtonNotifier = (
        email: email.value.text.isNotEmpty,
        password: password.value.text.isNotEmpty
      );
    });
    print(enableButtonNotifier);
  }

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


    return Scaffold(
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
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoginPageLogo(
                          logo: Image(
                            image: Assets.assets.images.facebook.provider(),
                            height: 25,
                            width: 25,
                          )),
                      SizedBox(width: 22),
                      LoginPageLogo(
                          logo: Image(
                            image: Assets.assets.images.google.provider(),
                            height: 25,
                            width: 25,
                          )),
                      SizedBox(width: 22),
                      LoginPageLogo(
                          logo: Image(
                            image: Assets.assets.images.apple.provider(),
                            height: 25,
                            width: 25,
                          )),
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
                        ),
                        const SizedBox(height: 20),
                        const CustomText('Password'),
                        CustomPasswordField(
                          controller: password,
                          hintText: 'Enter your password',
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
                            context.go("/forgetPassword");
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
