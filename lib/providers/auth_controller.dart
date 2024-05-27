import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/navigation/routes/routes_name.dart';

part 'auth_controller.g.dart';

@riverpod
class authController extends _$authController {
  @override
  dynamic build() {}

  dynamic signIn(String email, String password, BuildContext context) async {
    state = const AsyncLoading();
    state = await post(
      Uri.parse('http://34.72.136.54:4067/api/v1/auth/login'),
      body: {
        'email': email,
        'password': password,
        'OS': 'IOS',
        'model': 'iPhone 15',
        'FCMToken': 'Token1',
      },
    );

    if (state!.statusCode == 201) {
      GoRouter.of(context!).pushNamed(Routes.profile);
    } else {
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
  }

  dynamic forgetPassword(String email, BuildContext context) async {
    state = const AsyncLoading();
    state = await post(
      Uri.parse('http://34.72.136.54:4067/api/v1/auth/forget-password'),
      body: {
        'email': email,
      },
    );

    if (state!.statusCode == 201) {
      String? Email = email;
      String pageSelector = "forgetPassword";
      print('OTP sent successfully');
      context.go('/emailConfirmation/$Email/$pageSelector');
    } else {
      print('failed');
      showDialog(
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

  dynamic emailConfirmation(String email, String otp, String pageSelector,
      BuildContext context) async {
    state = const AsyncLoading();
    state = await post(
      Uri.parse('http://34.72.136.54:4067/api/v1/auth/verifyOtp'),
      body: {
        'email': email,
        'otp': otp,
      },
    );

    if (state!.statusCode == 201) {
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
                  if (pageSelector == "signUp") {
                    context.go('/');
                  } else if (pageSelector == "forgetPassword") {
                    context.go('/resetPassword/${email}');
                  }
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      print('Already account created.Login');
      showDialog(
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
}

@riverpod
class Login extends _$Login {
  @override
  FutureOr<bool?> build() async {
    return null;
  }

  void signIn({required String email, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await post(
        Uri.parse('http://34.72.136.54:4067/api/v1/auth/login'),
        body: {
          'email': email,
          'password': password,
          'OS': 'IOS',
          'model': 'iPhone 15',
          'FCMToken': 'Token1',
        },
      );
      if(response.statusCode != 201) {
        throw Exception('Something went wrong');
      } else {
        return true;
      }
    });
  }
}

@riverpod
class Signup extends _$Signup {
  @override
  FutureOr<bool?> build() async {
    return null;
  }

  void signUp({required String firstname,required String lastname,
    required String email, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await post(
        Uri.parse('http://34.72.136.54:4067/api/v1/auth/signUp'),
        body: {
          'firstname': firstname,
          'lastname': lastname,
          'email': email,
          'password': password,
        },
      );
      if(response.statusCode != 201) {
        throw Exception('Something went wrong');
      } else {
        return true;
      }
    });
  }
}

@riverpod
class EmailConfirmation extends _$EmailConfirmation {
  @override
  FutureOr<bool?> build() async {
    return null;
  }

  void otpConfirmation({required String email,required String otp,})
  async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await post(
        Uri.parse('http://34.72.136.54:4067/api/v1/auth/verifyOtp'),
        body: {
          'email': email,
          'otp': otp,
        },
      );
      if(response.statusCode != 201) {
        throw Exception('Something went wrong');
      } else {
        return true;
      }
    });
  }
}

@riverpod
class ForgetPassword extends _$ForgetPassword {
  @override
  FutureOr<bool?> build() async {
    return null;
  }

  void otpConfirmation({required String email})
  async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await post(
        Uri.parse('http://34.72.136.54:4067/api/v1/auth/forget-password'),
        body: {
          'email': email,
        },
      );
      if(response.statusCode != 201) {
        throw Exception('Something went wrong');
      } else {
        return true;
      }
    });
  }
}