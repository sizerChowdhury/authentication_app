import 'dart:async';
import 'package:http/http.dart';

class ResetPasswordRepository {
  FutureOr<bool?> resetPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await post(
      Uri.parse('http://34.72.136.54:4067/api/v1/auth/set-new-password'),
      body: {
        'email': email,
        'password': password,
        "confirmPassword": confirmPassword,
      },
    );
    if (response.statusCode != 201) {
      throw Exception('Something went wrong');
    } else {
      return true;
    }
  }
}
