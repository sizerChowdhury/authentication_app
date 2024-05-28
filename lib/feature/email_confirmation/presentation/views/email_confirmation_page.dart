import 'dart:async';
import 'package:authentication_app/core/widgets/appbar_tittle.dart';
import 'package:authentication_app/core/widgets/custom_text.dart';
import 'package:authentication_app/core/widgets/custom_text_filed.dart';
import 'package:authentication_app/core/widgets/custom_underline.dart';
import 'package:authentication_app/core/widgets/custom_welcome_text.dart';
import 'package:authentication_app/feature/email_confirmation/controller/email_confirmation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EmailConfirmation extends ConsumerStatefulWidget {
  final String email;
  final String pageSelector;
  EmailConfirmation(
  {super.key, required this.email, required this.pageSelector});

  @override
  ConsumerState<EmailConfirmation> createState() => _EmailConfirmationState();
}

class _EmailConfirmationState extends ConsumerState<EmailConfirmation> {
  TextEditingController otp = TextEditingController();

  ({bool otp}) enableButtonNotifier = (otp: false);

  @override
  void initState() {
    super.initState();

    otp.addListener(
          () => updateEnableButtonNotifier(),
    );
  }

  void updateEnableButtonNotifier() {
    setState(() {
      enableButtonNotifier = (
      otp: otp.value.text.isNotEmpty,
      );
    });
    print(enableButtonNotifier);
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(emailConfirmationProvider);

    ref.listen(emailConfirmationProvider, (_, next) {
      if (next.value ?? false) {
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
      } else if (next.hasError && !next.isLoading) {
        _buildShowDialog(context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Stack(
          children: [AppbarTittle('Email Confirmation'), Underline(right: 77)],
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
                    "We've sent a code to your email address"),
                const CustomWelcomeText('Please check your inbox'),
                const SizedBox(height: 100),

                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText('Your code'),
                      CustomTextField(
                        controller: otp,
                        hintText: '',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 280),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: ElevatedButton(
                    onPressed: (enableButtonNotifier.otp)
                        ? () => ref.read(emailConfirmationProvider.notifier).
                    otpConfirmation(
                      email: widget.email,
                      otp: otp.text.toString(),
                    )
                        : null,
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        (enableButtonNotifier.otp)
                            ? const Color(0xFF24786D)
                            : const Color(0xFFD0CCC1),
                      ),
                      minimumSize: const WidgetStatePropertyAll(
                          Size(double.infinity, 50)),
                    ),
                    child: loginState.isLoading
                        ? const CircularProgressIndicator(
                        backgroundColor: Colors.white)
                        : (enableButtonNotifier.otp)
                        ? const Text(
                      'Submit',
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                    )
                        : const Text(
                      'Submit',
                      style: TextStyle(color: Color(0xFF797C7B)),
                    ),
                  ),
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
  }
}
