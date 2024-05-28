import 'package:authentication_app/core/widgets/appbar_tittle.dart';
import 'package:authentication_app/core/widgets/custom_password_filed.dart';
import 'package:authentication_app/core/widgets/custom_text.dart';
import 'package:authentication_app/core/widgets/custom_underline.dart';
import 'package:authentication_app/core/widgets/custom_welcome_text.dart';
import 'package:authentication_app/feature/reset_password/controller/reset_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class ResetPassword extends ConsumerStatefulWidget {
  final String email;
  final String previousPage = "forgetPassword";
  ResetPassword({super.key, required this.email});

  @override
  ConsumerState<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends ConsumerState<ResetPassword> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  ({bool password, bool confirmPassword}) enableButtonNotifier = (password: false, confirmPassword: false);

  @override
  void initState() {
    super.initState();

    password.addListener(
          () => updateEnableButtonNotifier(),
    );
    confirmPassword.addListener(
          () => updateEnableButtonNotifier(),
    );
  }

  void updateEnableButtonNotifier() {
    setState(() {
      enableButtonNotifier = (
      password: password.value.text.isNotEmpty,
      confirmPassword: confirmPassword.value.text.isNotEmpty
      );
    });
    print(enableButtonNotifier);
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(resetPasswordProvider);

    ref.listen(resetPasswordProvider, (_, next) {
      if (next.value ?? false) {
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
                    "Please enter a new password. Don't enter"),
                const CustomWelcomeText('your old password'),
                const SizedBox(height: 100),

                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
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
                const SizedBox(height: 280),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: ElevatedButton(
                    onPressed: (enableButtonNotifier.password && enableButtonNotifier.confirmPassword)
                        ? () => ref.read(resetPasswordProvider.notifier).
                    resetPassword(
                      email: widget.email,
                      password: password.text.toString(),
                      confirmPassword: confirmPassword.text.toString()
                    )
                        : null,
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        (enableButtonNotifier.password && enableButtonNotifier.confirmPassword)
                            ? const Color(0xFF24786D)
                            : const Color(0xFFD0CCC1),
                      ),
                      minimumSize: const WidgetStatePropertyAll(
                          Size(double.infinity, 50)),
                    ),
                    child: loginState.isLoading
                        ? const CircularProgressIndicator(
                        backgroundColor: Colors.green)
                        : (enableButtonNotifier.password && enableButtonNotifier.confirmPassword)
                        ? const Text(
                      'Reset password',
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                    )
                        : const Text(
                      'Reset password',
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
}

