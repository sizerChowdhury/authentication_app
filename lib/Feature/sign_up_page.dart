
import 'package:device_info_plus/device_info_plus.dart';
import 'package:first_app/Feature/forget_password_page.dart';
import 'package:first_app/core/widgets/appbar_tittle.dart';
import 'package:first_app/core/gen/fonts.gen.dart';
import 'package:first_app/Feature/sign_up_page.dart';
import 'package:first_app/Feature/update_profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import '../core/navigation/routes/routes_name.dart';
import '../core/widgets/circular_tile.dart';
import '../core/widgets/custom_password_filed.dart';
import '../core/widgets/custom_text.dart';
import '../core/widgets/custom_text_filed.dart';
import '../core/widgets/custom_welcome_text.dart';
import '../core/widgets/custom_underline.dart';
import '../providers/auth_controller.dart';
import '../providers/login_button_controller.dart';


class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();

  ({bool email, bool password, bool firstname, bool lastname})
  enableButtonNotifier =
  (email: false, password: false, firstname: false, lastname: false);

  @override
  void initState() {
    super.initState();
    firstname.addListener(
          () => updateEnableButtonNotifier(),
    );

    lastname.addListener(
          () => updateEnableButtonNotifier(),
    );
    email.addListener(
          () => updateEnableButtonNotifier(),
    );
    password.addListener(
          () => updateEnableButtonNotifier(),
    );
  }

  void updateEnableButtonNotifier() {
    setState(() {
      enableButtonNotifier = (
      firstname: firstname.value.text.isNotEmpty,
      lastname: lastname.value.text.isNotEmpty,
      email: email.value.text.isNotEmpty,
      password: password.value.text.isNotEmpty
      );
    });
    print(enableButtonNotifier);
  }
  bool isButtonEnable = false;

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(signupProvider);

    ref.listen(signupProvider, (_, next) {
      if (next.value ?? false) {
        String? Email = email.text.toString();
        String pageSelector = "signUp";
        print('signup successful');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Account Created successfully!'),
              content: Text('Press OK and verify your email.'),
              actions: [
                TextButton(
                  onPressed: () {
                    context.go('/emailConfirmation/$Email/$pageSelector');
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
          children: [AppbarTittle('Sign up with Email'), Underline(right: 77)],
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
                    'Get chatting with friends and family today by'),
                const CustomWelcomeText('signing up for our chat app!'),
                const SizedBox(height: 55),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText('First name'),
                        CustomTextField(
                          controller: firstname,
                          hintText: '',
                        ),
                        SizedBox(height: 10),
                        CustomText('Last name'),
                        CustomTextField(
                          controller: lastname,
                          hintText: '',
                        ),
                        SizedBox(height: 10),
                        CustomText('Your email'),
                        CustomTextField(
                          controller: email,
                          hintText: '',
                        ),
                        SizedBox(height: 10),
                        CustomText('Password'),
                        CustomPasswordField(
                          controller: password,
                          hintText: '',
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 115),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: ElevatedButton(
                    onPressed: (enableButtonNotifier.email &&
                        enableButtonNotifier.password &&
                        enableButtonNotifier.firstname &&
                        enableButtonNotifier.lastname
                    )
                        ? () => ref.read(signupProvider.notifier).signUp(
                      firstname: firstname.text.toString(),
                      lastname: lastname.text.toString(),
                      email: email.text.toString(),
                      password: password.text.toString(),
                    )
                        : null,
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        (enableButtonNotifier.email &&
                            enableButtonNotifier.password &&
                            enableButtonNotifier.firstname &&
                            enableButtonNotifier.lastname)
                            ? const Color(0xFF24786D)
                            : const Color(0xFFD0CCC1),
                      ),
                      minimumSize: const WidgetStatePropertyAll(
                          Size(double.infinity, 50)),
                    ),
                    child: loginState.isLoading
                        ? const CircularProgressIndicator(
                        backgroundColor: Colors.white)
                        : (enableButtonNotifier.email &&
                        enableButtonNotifier.password &&
                        enableButtonNotifier.firstname &&
                        enableButtonNotifier.lastname)
                        ? const Text(
                      'Create an account',
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                    )
                        : const Text(
                      'Create an account',
                      style: TextStyle(color: Color(0xFF797C7B)),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    GoRouter.of(context).pushNamed(Routes.signup);
                  },
                  child: const CustomText("Already  have an account?Log In"),
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

