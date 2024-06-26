import 'dart:async';
import 'package:http/http.dart';

class SignupRepository {
  FutureOr<bool?> signUp({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  }) async {
    final response = await post(
      Uri.parse('http://34.72.136.54:4067/api/v1/auth/signUp'),
      body: {
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode != 201) {
      throw Exception('Something went wrong');
    } else {
      return true;
    }
  }
}
