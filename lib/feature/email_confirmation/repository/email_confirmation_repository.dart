import 'dart:async';
import 'package:http/http.dart';

class EmailConfirmationRepository {
  FutureOr<bool?> emailConfirmation({
    required String email,
    required String otp,
  }) async {
    final response = await post(
      Uri.parse('http://34.72.136.54:4067/api/v1/auth/verifyOtp'),
      body: {
        'email': email,
        'otp': otp,
      },
    );

    if (response.statusCode != 201) {
      throw Exception('Something went wrong');
    } else {
      return true;
    }
  }
}
