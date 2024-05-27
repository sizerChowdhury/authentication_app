import 'dart:async';

import 'package:first_app/core/widgets/appbar_tittle.dart';
import 'package:first_app/core/widgets/button_text.dart';
import 'package:first_app/core/widgets/custom_text_filed.dart';
import 'package:first_app/core/widgets/custom_welcome_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';

import '../core/widgets/custom_button.dart';
import '../core/widgets/custom_text.dart';
import '../core/widgets/custom_underline.dart';
import '../core/gen/fonts.gen.dart';
import '../providers/auth_controller.dart';
import '../providers/email_textfield_controller.dart';
import '../providers/otp_field_controller.dart';

class EmailConfirmation extends ConsumerWidget {
  final String email;
  final String pageSelector;
  EmailConfirmation(
      {super.key, required this.email, required this.pageSelector});

  TextEditingController code = TextEditingController();


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    dynamic state = ref.watch(authControllerProvider);
    bool otpState = ref.watch(otpControllerProvider);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (pageSelector == "signUp") {
                context.go("/signUp");
              } else if (pageSelector == "forgetPassword") {
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
                              ref.read(otpControllerProvider.notifier).update();
                              print(otpState);
                            }
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 350),
                  ElevatedButton(
                    onPressed: otpState? () {
                      ref.read(authControllerProvider.notifier).emailConfirmation(
                          email,
                          code.text.toString(),
                          pageSelector,
                          context);
                    }:null,
                    child: (state?.runtimeType.toString() == 'AsyncLoading<dynamic>')
                        ? const CircularProgressIndicator(
                        backgroundColor: Colors.white)
                        : Text(
                      'Submit',
                      style: const TextStyle(
                        fontFamily: FontFamily.circular,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xFF797C7B),
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        otpState?Color(0xFF24786D):Color(0xFFD0CCC1),
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

  // void buttonCall() async {
  //   try {
  //     Response response = await post(
  //       Uri.parse('http://34.72.136.54:4067/api/v1/auth/verifyOtp'),
  //       body: {
  //         'email': widget.email,
  //         'otp': code.text.toString(),
  //       },
  //     );
  //     print(response.statusCode);
  //     if (response.statusCode == 201) {
  //       print('OTP varrified successfully');
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text('Email verification successful'),
  //             content: Text('Press OK'),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   if (widget.pageSelector == "signUp") {
  //                     context.go('/');
  //                   } else if (widget.pageSelector == "forgetPassword") {
  //                     context.go('/resetPassword/${widget.email}');
  //                   }
  //                 },
  //                 child: Text('OK'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     } else if (response.statusCode == 409) {
  //       print('Already account created.Login');
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text('User already exist. Please Login'),
  //             content: Text('Failed to create new account.'),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Text('OK'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     } else {
  //       print('Wrong OTP');
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}
