import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  Future<bool> logIn(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://34.72.136.54:4067/api/v1/auth/login'),
        body: {
          'email': email,
          'password': password,
          'OS': 'IOS',
          'model': 'iPhone 15',
          'FCMToken': 'Token1',
        },
      );

      if (response.statusCode == 201) {
        final token = jsonDecode(response.body)["token"];
        await _saveTokenToCache(token);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> _saveTokenToCache(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
    } catch (e) {
      throw Exception('Something went wrong');
    }
  }
}
