
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/navigation/routes/routes_name.dart';
part 'auth_controller.g.dart';
@riverpod
class authController extends _$authController{
  @override
  dynamic build(){
  }
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

    if (state!.statusCode == 201)
      GoRouter.of(context!).pushNamed(Routes.profile);
    else {
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
}