import 'dart:async';

import 'package:first_app/core/widgets/appbar_tittle.dart';
import 'package:first_app/core/widgets/button_text.dart';
import 'package:first_app/core/widgets/custom_text_filed.dart';
import 'package:first_app/core/widgets/custom_welcome_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';

import '../core/widgets/custom_button.dart';
import '../core/widgets/custom_text.dart';
import '../core/widgets/custom_underline.dart';
import '../core/gen/fonts.gen.dart';

class EmailConfirmation extends StatefulWidget {
  final String email;
  final String pageSelector;
  EmailConfirmation(
      {super.key, required this.email, required this.pageSelector});

  @override
  State<EmailConfirmation> createState() => _EmailConfirmationState();
}

class _EmailConfirmationState extends State<EmailConfirmation> {
  TextEditingController code = TextEditingController();
  Timer? _timer;
  int _countDown = 10;
  bool canResend = false;
  String userCode = '';
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countDown > 0) {
          _countDown--;
        } else {
          _timer?.cancel();
          canResend = true;
        }
      });
    });
  }

  void resendOtp() {
    if (canResend == true) {
      setState(() {
        _countDown = 10;
        canResend = false;
      });
      startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (widget.pageSelector == "signUp") {
                context.go("/signUp");
              } else if (widget.pageSelector == "forgetPassword") {
                context.go("/forgetPassword");
              }
            },
          ),
          title: Stack(
            children: [
              AppbarTittle('Email Confirmation'),
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
                  CustomWelcomeText("We've sent a code to your email address"),
                  CustomWelcomeText("Please check your inbox"),
                  SizedBox(height: 140),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText('Your code'),
                        CustomTextField(
                          hintText: '',
                          controller: code,
                          onChanged: (value) {
                            setState(() {
                              userCode = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 350),
                  ElevatedButton(
                    onPressed: userCode != '' ? buttonCall : null,
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontFamily: FontFamily.circular,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    style: userCode != ''
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
                  if (_countDown > 0)
                    CustomText(
                      "Resend Email in ${_countDown.toString()} seconds",
                    ),
                  if (_countDown == 0)
                    TextButton(
                      onPressed: () async {
                        try {
                          Response response = await post(
                            Uri.parse(
                                'http://34.72.136.54:4067/api/v1/auth/resend-otp'),
                            body: {
                              'email': widget.email,
                            },
                          );
                          print(response.statusCode);
                          if (response.statusCode == 201) {
                            print('Resend OTP successfully');
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Resend OTP successfully!'),
                                  content: Text('Check your inbox'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        resendOtp();
                                        Navigator.of(context).pop();
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
                                  title:
                                      Text('User already exist. Please Login'),
                                  content:
                                      Text('Failed to create new account.'),
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
                            print('Wrong OTP');
                          }
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                      child: CustomText("Resend Email"),
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
        Uri.parse('http://34.72.136.54:4067/api/v1/auth/verifyOtp'),
        body: {
          'email': widget.email,
          'otp': code.text.toString(),
        },
      );
      print(response.statusCode);
      if (response.statusCode == 201) {
        print('OTP varrified successfully');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Email verification successful'),
              content: Text('Press OK'),
              actions: [
                TextButton(
                  onPressed: () {
                    if (widget.pageSelector == "signUp") {
                      context.go('/');
                    } else if (widget.pageSelector == "forgetPassword") {
                      context.go('/resetPassword/${widget.email}');
                    }
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
        print('Wrong OTP');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
