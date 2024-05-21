import 'package:first_app/core/widgets/appbar_tittle.dart';
import 'package:first_app/core/widgets/button_text.dart';
import 'package:first_app/core/widgets/custom_welcome_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';

import '../core/widgets/custom_button.dart';
import '../core/widgets/custom_password_filed.dart';
import '../core/widgets/custom_text.dart';
import '../core/widgets/custom_underline.dart';
import '../core/gen/fonts.gen.dart';

class ResetPassword extends StatelessWidget {
  final String email;
  final String previousPage = "forgetPassword";
  ResetPassword({super.key, required this.email});
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              context.go("/emailConfirmation/${email}/${previousPage}");
            },
          ),
          title: Stack(
            children: [
              AppbarTittle('Reset Password'),
              Underline(right: 77),
            ],
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  CustomWelcomeText("Please enter a new password. Don't enter"),
                  CustomWelcomeText('your old password'),
                  SizedBox(height: 110),
                  Padding(
                    padding: const EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText('Password'),
                        CustomPasswordField(
                          controller: password,
                          hintText: '',
                        ),
                        SizedBox(height: 20),
                        CustomText('Confirm Password'),
                        CustomPasswordField(
                          controller: confirmPassword,
                          hintText: '',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 80),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 35, right: 35),
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          Response response = await post(
                            Uri.parse(
                                'http://34.72.136.54:4067/api/v1/auth/set-new-password'),
                            body: {
                              'email': email,
                              'password': password.text.toString(),
                              "confirmPassword": confirmPassword.text.toString()
                            },
                          );
                          print(response.statusCode);
                          if (response.statusCode == 201 ||
                              response.statusCode == 200) {
                            print('password changed successfully');
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Password Reset successfully!'),
                                  content: Text('Press OK and logIn.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        context.go('/');
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            print('Password reset failed. Verify OTP');
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Error! Bad request.'),
                                  content:
                                      Text('Password reset failed. Verify OTP'),
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
                      },
                      child: Text(
                        'Reset Password',
                        style: TextStyle(
                          fontFamily: FontFamily.circular,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xFF797C7B),
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xFFF3F6F6),
                        ),
                      ),
                    ),
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
