import 'package:first_app/core/widgets/appbar_tittle.dart';
import 'package:first_app/core/widgets/button_text.dart';
import 'package:first_app/core/widgets/custom_text_filed.dart';
import 'package:first_app/core/widgets/custom_welcome_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../core/navigation/routes/routes_name.dart';
import '../core/widgets/custom_button.dart';
import '../core/widgets/custom_text.dart';
import '../core/widgets/custom_underline.dart';
import '../core/gen/fonts.gen.dart';
import '../counter.dart';

// Define a state class to hold the data, error, and loading status
class EmailConfirmationState {
  String? error;
  bool isLoading;
  bool isSuccess;

  EmailConfirmationState({
    this.error,
    this.isLoading = false,
    this.isSuccess = false,
  });

  // CopyWith method to create a new instance with updated values
  EmailConfirmationState copyWith({
    String? error,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return EmailConfirmationState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

final emailConfirmationProvider =
StateNotifierProvider<EmailConfirmationNotifier, EmailConfirmationState>(
        (ref) => EmailConfirmationNotifier());

class EmailConfirmationNotifier extends StateNotifier<EmailConfirmationState> {
  EmailConfirmationNotifier() : super(EmailConfirmationState());

  Future<void> submitEmail(String email) async {
    state = state.copyWith(isLoading: true); // Set loading to true
    try {
      final response = await http.post(
        Uri.parse('http://34.72.136.54:4067/api/v1/auth/forget-password'),
        body: {'email': email},
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        state = state.copyWith(isSuccess: true);
      } else {
        state = state.copyWith(error: 'Invalid Email or Password');
      }
    } catch (e) {
      state = state.copyWith(error: 'Error occurred');
    } finally {
      state = state.copyWith(isLoading: false); // Set loading to false
    }
  }
}



class ForgetPassword extends ConsumerWidget {
  ForgetPassword({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    //final counter = ref.watch(counterProvider);
    final state = ref.watch(emailConfirmationProvider);
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
                  SizedBox(height: 140),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText('Your email'),
                        CustomTextField(
                          hintText: 'Enter your emailll',
                          controller: emailController,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 220),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 35, right: 35),
                    child: ElevatedButton(
                      onPressed: state.isLoading
                          ? null
                          : () async {
                        await ref
                            .read(emailConfirmationProvider.notifier)
                            .submitEmail(emailController.text);
                        if (state.isSuccess) {
                          String email = emailController.text;
                          String pageSelector = "forgetPassword";
                          context.go('/emailConfirmation/$email/$pageSelector');
                        } else if (state.error != null) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Error! Bad request.'),
                                content: Text(state.error!),
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
                      },
                      child: state.isLoading
                          ? CircularProgressIndicator() // Show loading indicator
                          : Text('Submit'),
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
