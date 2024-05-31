import 'dart:async';
import 'package:http/http.dart';

class ForgetPasswordRepository {
  FutureOr<bool?> forgetPassword({required String email}) async {
    final response = await post(
      Uri.parse('http://34.72.136.54:4067/api/v1/auth/forget-password'),
      body: {
        'email': email,
      },
    );
    if (response.statusCode != 201) {
      throw Exception('Something went wrong');
    } else {
      return true;
    }
  }
}
