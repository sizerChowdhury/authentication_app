
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import '../core/gen/fonts.gen.dart';
import '../core/widgets/appbar_tittle.dart';
import '../core/widgets/custom_text.dart';
import '../core/widgets/custom_text_filed.dart';
import '../core/widgets/custom_underline.dart';
import '../core/widgets/custom_welcome_text.dart';
import '../providers/auth_controller.dart';
import '../providers/email_textfield_controller.dart';


class ForgetPassword extends ConsumerWidget {
  ForgetPassword({super.key});
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    dynamic state = ref.watch(authControllerProvider);
    bool emailState = ref.watch(emailControllerProvider);
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
                            onChanged: (value) {
                              ref.read(emailControllerProvider.notifier).update();
                            }
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 150),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 35, right: 35),
                    child: ElevatedButton(
                      onPressed: emailState? () {
                        ref.read(authControllerProvider.notifier).forgetPassword(
                            email.text.toString(),
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
                            emailState?Color(0xFF24786D):Color(0xFFD0CCC1),
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