import 'package:first_app/core/widgets/appbar_tittle.dart';
import 'package:first_app/core/widgets/button_text.dart';
import 'package:first_app/core/widgets/custom_password_filed.dart';
import 'package:first_app/core/widgets/custom_text_filed.dart';
import 'package:first_app/core/widgets/custom_welcome_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import '../core/widgets/custom_button.dart';
import '../core/widgets/custom_text.dart';
import '../core/widgets/custom_underline.dart';

void main() {
  runApp(const ChangePassword());
}

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              context.go("/");
            },
          ),
          title: Stack(
            children: [
              AppbarTittle('Change Password'),
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
                  CustomWelcomeText("Make sure to enter a strong password to"),
                  CustomWelcomeText("ensure your security"),
                  SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText('Old Password'),
                        //CustomPasswordField(hintText: ''),
                        SizedBox(height: 20),
                        CustomText('Password'),
                        //CustomPasswordField(hintText: ''),
                        SizedBox(height: 20),
                        CustomText('Confirm Password'),
                        //CustomPasswordField(hintText: ''),
                      ],
                    ),
                  ),
                  SizedBox(height: 60),
                  CustomButton(buttonText: 'Reset Password', url: '/'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
