import 'package:device_info_plus/device_info_plus.dart';
import 'package:first_app/Feature/forget_password_page.dart';
import 'package:first_app/core/widgets/appbar_tittle.dart';
import 'package:first_app/core/gen/fonts.gen.dart';
import 'package:first_app/Feature/sign_up_page.dart';
import 'package:first_app/Feature/update_profile_page.dart';
import 'package:flutter/material.dart';
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
import 'dart:io';
import '../core/widgets/custom_button.dart';
import 'sign_up_page.dart';
import 'forget_password_page.dart';
import 'email_confirmation_page.dart';
import 'reset_password_page.dart';
import 'change_password_page.dart';
import 'update_profile_page.dart';
import 'package:first_app/core/gen/assets.gen.dart';

void main() {
  runApp(LogIn());
}

class LogIn extends StatefulWidget {
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  //const LogIn({super.key});
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isSecurePassword = true;
  String userEmail = '';
  String userPass = '';

  @override
  Widget build(BuildContext context) {
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
                  SizedBox(height: 25),
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
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 35, right: 35),
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
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText('Email'),
                        CustomTextField(
                          controller: email,
                          hintText: 'Enter your email',
                          onChanged: (value) {
                            setState(() {
                              userEmail = value;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        CustomText('Password'),
                        CustomPasswordField(
                          controller: password,
                          hintText: 'Enter your password',
                          onChanged: (value) {
                            setState(() {
                              userPass = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 35),
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
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 35, right: 35),
                    child: ElevatedButton(
                        onPressed: userEmail != '' && userPass != ''
                            ? buttonCall
                            : null,
                        child: Text(
                          'LogIn',
                          style: TextStyle(
                            fontFamily: FontFamily.circular,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        style: userEmail != '' && userPass != ''
                            ? ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Color(0xFF24786D),
                                ),
                              )
                            : ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Color(0xFFD0CCC1),
                                ),
                              )),
                  ),
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).pushNamed(Routes.signup);
                    },
                    child: CustomText("Don'tt  have an account?Sign Up"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void buttonCall() async {
    // setState(() {
    //   isButtonActive = false;
    // });
    try {
      Response response = await post(
        Uri.parse('http://34.72.136.54:4067/api/v1/auth/login'),
        body: {
          'email': email.text.toString(),
          'password': password.text.toString(),
          "OS": "Android",
          "model": "Nexus 6",
          "FCMToken": "Token1"
        },
      );
      print(response.statusCode);
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('login successful');
        GoRouter.of(context).pushNamed(Routes.profile);
      } else {
        print('login failed');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error! Bad request.'),
              content: Text('Invalid Email or Password'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
