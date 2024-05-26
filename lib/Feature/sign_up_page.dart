// import 'dart:html';

import 'package:first_app/core/widgets/custom_welcome_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import '../core/widgets/circular_tile.dart';
import '../core/widgets/appbar_tittle.dart';
import '../core/widgets/button_text.dart';
import '../core/widgets/custom_button.dart';
import '../core/widgets/custom_password_filed.dart';
import '../core/widgets/custom_text.dart';
import '../core/widgets/custom_text_filed.dart';
import '../core/widgets/custom_underline.dart';
import '../core/gen/fonts.gen.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController firstname = TextEditingController();

  TextEditingController lastname = TextEditingController();

  String userFirstname = '';

  String userLastname = '';

  String userEmail = '';

  String userPass = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Stack(
            children: [
              AppbarTittle('Sign up with Email'),
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
                  SizedBox(
                    height: 60,
                  ),
                  CustomWelcomeText(
                      'Get chatting with friends and family today by'),
                  CustomWelcomeText('signing up for our chat app!'),
                  SizedBox(height: 45),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText('First name'),
                        CustomTextField(
                          controller: firstname,
                          hintText: '',
                          onChanged: (value) {
                            setState(() {
                              userFirstname = value;
                            });
                          },
                        ),
                        SizedBox(height: 10),
                        CustomText('Last name'),
                        CustomTextField(
                          controller: lastname,
                          hintText: '',
                          onChanged: (value) {
                            setState(() {
                              userLastname = value;
                            });
                          },
                        ),
                        SizedBox(height: 10),
                        CustomText('Your email'),
                        CustomTextField(
                          controller: email,
                          hintText: '',
                          onChanged: (value) {
                            setState(() {
                              userEmail = value;
                            });
                          },
                        ),
                        SizedBox(height: 10),
                        CustomText('Password'),
                        CustomPasswordField(
                          controller: password,
                          hintText: '',
                          onChanged: (value) {
                            setState(() {
                              userPass = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 140),
                  // CustomButton(
                  //     buttonText: 'Create an account', url: '/updateProfile'),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 24, right: 24),
                    child: ElevatedButton(
                      onPressed: userEmail != '' &&
                              userPass != '' &&
                              userFirstname != '' &&
                              userLastname != ''
                          ? buttonCall
                          : null,
                      child: Text(
                        'Create an Account',
                        style: TextStyle(
                          fontFamily: FontFamily.circular,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      style: userEmail != '' &&
                              userPass != '' &&
                              userFirstname != '' &&
                              userLastname != ''
                          ? ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF24786D),
                              ),
                            )
                          : ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFD0CCC1),
                              ),
                            ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.go("/");
                    },
                    child: CustomText("Already have an account? Login"),
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
    try {
      Response response = await post(
        Uri.parse('http://34.72.136.54:4067/api/v1/auth/signUp'),
        body: {
          'firstname': firstname.text.toString(),
          'lastname': lastname.text.toString(),
          'email': email.text.toString(),
          'password': password.text.toString(),
        },
      );
      print(response.statusCode);
      if (response.statusCode == 201) {
        String? Email = email.text.toString();
        String pageSelector = "signUp";
        print('signup successful');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Account Created successfully!'),
              content: Text('Press OK and verify your email.'),
              actions: [
                TextButton(
                  onPressed: () {
                    context.go('/emailConfirmation/$Email/$pageSelector');
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else if (response.statusCode == 409) {
        print('Already account created.Login');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('User already exist. Please Login'),
              content: Text('Failed to create new account.'),
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
      } else {
        print('Fa');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
