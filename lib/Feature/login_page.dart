import 'package:device_info_plus/device_info_plus.dart';
import 'package:first_app/Feature/forget_password_page.dart';
import 'package:first_app/core/widgets/appbar_tittle.dart';
import 'package:first_app/core/gen/fonts.gen.dart';
import 'package:first_app/Feature/sign_up_page.dart';
import 'package:first_app/Feature/update_profile_page.dart';
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

class LogIn extends ConsumerWidget {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  LogIn({super.key});
  bool _isSecurePassword = true;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    dynamic state = ref.watch(authControllerProvider);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Stack(
            children: [AppbarTittle('Log In to Authy'), Underline(right: 77)],
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 45),
                  CustomWelcomeText('Welcome back! Sign in using your social'),
                  CustomWelcomeText('account or email to continue us'),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularTile(imagePath: 'Assets/Images/facebook.png'),
                      SizedBox(width: 22),
                      CircularTile(imagePath: 'Assets/Images/google.png'),
                      SizedBox(width: 22),
                      CircularTile(imagePath: 'Assets/Images/apple.png'),
                    ],
                  ),
                  SizedBox(height: 55),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            height: 1, width: 150, color: Color(0xFFCDD1D0)),
                        Text(
                          'OR',
                          style: TextStyle(
                            fontFamily: FontFamily.circular,
                            color: Color(0xFFCDD1D0),
                          ),
                        ),
                        Container(
                          height: 1,
                          width: 150,
                          color: Color(0xFFCDD1D0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText('Email'),
                        CustomTextField(
                          controller: email,
                          hintText: 'Enter your email',
                        ),
                        SizedBox(height: 20),
                        CustomText('Password'),
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
                              CustomText('Remember Me'),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            //context.go("/forgetPassword");
                            GoRouter.of(context).pushNamed(Routes.forgetPassword);
                          },
                          child: CustomText('Forget Passwordd'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 115),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 24, right: 24),
                    child: ElevatedButton(
                        onPressed: () {
                          ref.read(authControllerProvider.notifier).signIn(
                            email.text.toString(),password.text.toString(),
                            context
                          );
                        },
                        child:(state?.runtimeType.toString()=='AsyncLoading<dynamic>')
                            ? const CircularProgressIndicator()
                            : Text('LogIn',
                          style: TextStyle(
                            fontFamily: FontFamily.circular,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xFF797C7B),
                          ),
                        ),
                    style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        Color(0xFFF3F6F6),
                  ),
              minimumSize: WidgetStatePropertyAll(
                Size(double.infinity, 50),
              ),
            ),
                    )
                  ),

                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).pushNamed(Routes.signup);
                    },
                    child: CustomText("Don't  have an account?Sign Up"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}