import 'package:authentication_app/core/widgets/password_filed.dart';
import 'package:authentication_app/core/widgets/title_underline.dart';
import 'package:authentication_app/feature/reset_password/controller/reset_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class ResetPasswordPage extends ConsumerStatefulWidget {
  final String email;
  final String previousPage = "forgetPassword";
  const ResetPasswordPage({super.key, required this.email});

  @override
  ConsumerState<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
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
  bool isButtonEnable = false;
  void updateEnableButtonNotifier() {
    setState(() {
      enableButtonNotifier = (
      password: password.value.text.isNotEmpty,
      confirmPassword: confirmPassword.value.text.isNotEmpty
      );
      isButtonEnable = enableButtonNotifier.password && enableButtonNotifier.confirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(resetPasswordProvider);

    ref.listen(resetPasswordProvider, (_, next) {
      if (next.value ?? false) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Password Reset successfully!'),
                                  content: const Text('Press OK and logIn.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        context.go('/');
                                      },
                                      child: const Text('OK'),
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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    Text('Forget Passwordd',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Underline(right: 77)
                  ],
                ),
                const SizedBox(height: 45),
                Text("Please enter a new password. Don't enter",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text('your old password',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 100),

                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text('Password',
                        style: Theme.of(context).textTheme.headlineLarge ,
                        ),
                        PasswordField(
                          controller: password,
                          hintText: '',
                        ),
                        const SizedBox(height: 20),
                        Text('Confirm Password',
                        style: Theme.of(context).textTheme.headlineLarge ,
                        ),
                        PasswordField(
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
                    onPressed: (isButtonEnable)
                        ? () => ref.read(resetPasswordProvider.notifier).
                    resetPassword(
                      email: widget.email,
                      password: password.text.toString(),
                      confirmPassword: confirmPassword.text.toString()
                    )
                        : null,
                    style: !(isButtonEnable)
                        ? const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Color(0xFFF3F6F6),
                      ),
                      minimumSize: WidgetStatePropertyAll(
                        Size(double.infinity, 50),
                      ),
                    ) : const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Color.fromARGB(255, 97, 145, 122),
                      ),
                      minimumSize: WidgetStatePropertyAll(
                        Size(double.infinity, 50),
                      ),
                    ),
                    child: loginState.isLoading
                        ? const CircularProgressIndicator(
                        backgroundColor: Colors.white,)
                        : (isButtonEnable)
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
          title: const Text('Error! Bad request.'),
          content:
          const Text('Password reset failed. Verify OTP'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                },
              child: const Text('OK'),
            ),
          ],
        );
        },
    );
  }
}

