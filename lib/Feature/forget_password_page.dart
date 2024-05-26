
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import '../core/gen/fonts.gen.dart';
import '../core/widgets/appbar_tittle.dart';
import '../core/widgets/custom_text.dart';
import '../core/widgets/custom_text_filed.dart';
import '../core/widgets/custom_underline.dart';
import '../core/widgets/custom_welcome_text.dart';

void main() {
  runApp(ForgetPassword());
}

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  TextEditingController email = TextEditingController();

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
              AppbarTittle('Forgot Password'),
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
                  SizedBox(height: 25),
                  CustomWelcomeText(
                      'Enter your email adrres. We will send a code'),
                  CustomWelcomeText('to verify your identity'),
                  SizedBox(height: 110),
                  Padding(
                    padding: const EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText('Your email'),
                        CustomTextField(
                          hintText: 'Enter your email',
                          controller: email,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 150),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 35, right: 35),
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          Response response = await post(
                            Uri.parse(
                                'http://34.72.136.54:4067/api/v1/auth/forget-password'),
                            body: {
                              'email': email.text.toString(),
                            },
                          );
                          print(response.statusCode);
                          if (response.statusCode == 201 ||
                              response.statusCode == 200) {
                            String? Email = email.text.toString();
                            String pageSelector = "forgetPassword";
                            print('OTP sent successfully');
                            context
                                .go('/emailConfirmation/$Email/$pageSelector');
                          } else {
                            print('failed');
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
                      },
                      child: Text(
                        'Submit',
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
                  TextButton(
                    onPressed: () {
                      context.go("/");
                    },
                    child: CustomText(
                      'Remember your Password? Login',
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