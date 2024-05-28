
import 'package:authentication_app/core/widgets/appbar_tittle.dart';
import 'package:authentication_app/core/widgets/custom_text.dart';
import 'package:authentication_app/core/widgets/custom_text_filed.dart';
import 'package:authentication_app/core/widgets/custom_underline.dart';
import 'package:authentication_app/core/widgets/custom_welcome_text.dart';
import 'package:authentication_app/feature/forget_password/controller/forget_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class ForgetPassword extends ConsumerStatefulWidget {

  ForgetPassword(
      {super.key});

  @override
  ConsumerState<ForgetPassword> createState() => _ForgetPasswordStae();
}

class _ForgetPasswordStae extends ConsumerState<ForgetPassword> {
  TextEditingController email = TextEditingController();

  ({bool email}) enableButtonNotifier = (email: false);

  @override
  void initState() {
    super.initState();

    email.addListener(
          () => updateEnableButtonNotifier(),
    );
  }

  void updateEnableButtonNotifier() {
    setState(() {
      enableButtonNotifier = (
      email: email.value.text.isNotEmpty,
      );
    });
    print(enableButtonNotifier);
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(forgetPasswordProvider);

    ref.listen(forgetPasswordProvider, (_, next) {
      if (next.value ?? false) {
        String? Email = email.text.toString();
        String pageSelector = "forgetPassword";
        print('OTP sent successfully');
        context.go('/emailConfirmation/$Email/$pageSelector');
      } else if (next.hasError && !next.isLoading) {
        _buildShowDialog(context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Stack(
          children: [AppbarTittle('Forgot Password'), Underline(right: 77)],
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
                    "Enter your email address. We will send a code"),
                const CustomWelcomeText('to verify your identity'),
                const SizedBox(height: 100),

                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText('Your email'),
                      CustomTextField(
                        controller: email,
                        hintText: 'Enter your email',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 280),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: ElevatedButton(
                    onPressed: (enableButtonNotifier.email)
                        ? () => ref.read(forgetPasswordProvider.notifier).
                    otpConfirmation(
                      email: email.text.toString(),
                    )
                        : null,
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        (enableButtonNotifier.email)
                            ? const Color(0xFF24786D)
                            : const Color(0xFFD0CCC1),
                      ),
                      minimumSize: const WidgetStatePropertyAll(
                          Size(double.infinity, 50)),
                    ),
                    child: loginState.isLoading
                        ? const CircularProgressIndicator(
                        backgroundColor: Colors.white)
                        : (enableButtonNotifier.email)
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
          title: Text('Error! Bad request.'),
          content: Text('Invalid Email'),
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