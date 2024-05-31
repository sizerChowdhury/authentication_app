import 'dart:async';
import 'package:authentication_app/core/widgets/title_underline.dart';
import 'package:authentication_app/feature/email_confirmation/controller/email_confirmation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EmailConfirmationPage extends ConsumerStatefulWidget {
  final String email;
  final String pageSelector;

  const EmailConfirmationPage({
    required this.email,
    required this.pageSelector,
    super.key,
  });

  @override
  ConsumerState<EmailConfirmationPage> createState() =>
      _EmailConfirmationPageState();
}

class _EmailConfirmationPageState extends ConsumerState<EmailConfirmationPage> {
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
      enableButtonNotifier = (otp: otp.value.text.isNotEmpty,);
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(emailConfirmationProvider);

    ref.listen(emailConfirmationProvider, (_, next) {
      if (next.value ?? false) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Email verification successful'),
              content: const Text('Press OK'),
              actions: [
                TextButton(
                  onPressed: () {
                    if (widget.pageSelector == "signUp") {
                      context.go('/');
                    } else if (widget.pageSelector == "forgetPassword") {
                      context.go('/resetPassword/${widget.email}');
                    }
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
                    Text(
                      'Email Confirmation',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Underline(right: 77),
                  ],
                ),
                const SizedBox(height: 45),
                Text(
                  "We've sent a code to your email address",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'Please check your inbox',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your code',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          hintText: '',
                        ),
                        controller: otp,
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
                        ? () => ref
                            .read(emailConfirmationProvider.notifier)
                            .otpConfirmation(
                              email: widget.email,
                              otp: otp.text.toString(),
                            )
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: (enableButtonNotifier.otp)
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.secondary,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: loginState.isLoading
                        ? const CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          )
                        : Text(
                            'Submit',
                            style: TextStyle(
                              color: (enableButtonNotifier.otp)
                                  ? Theme.of(context).colorScheme.surface
                                  : Theme.of(context).colorScheme.tertiary,
                            ),
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
          title: const Text('Failed'),
          content: const Text('Failed to send otp.'),
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
