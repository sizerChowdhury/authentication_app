import 'dart:async';
import 'dart:convert';

import 'package:authentication_app/feature/home_page/presentation/widgets/home_page_model.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageRepository {
  // static FutureOr<bool?> homePage() async {
  //   final token = await _getTokenFromCache();
  //   final response = await get(
  //     Uri.parse('http://34.72.136.54:4067/api/v1/auth/me'),
  //     headers: {'Authorization': 'Bearer $token'},
  //   );
  //   if (response.statusCode == 200) {
  //     final firstname = jsonDecode(response.body)["data"]["firstname"];
  //     final lastname = jsonDecode(response.body)["data"]["lastname"];
  //     final email = jsonDecode(response.body)["data"]["email"];
  //     await _saveDataToCache(firstname, lastname, email);
  //     return true;
  //   } else {
  //     throw Exception('Something went wrong');
  //   }
  // }
  //
  // static Future<String> _getTokenFromCache() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('token') ?? '';
  // }
  //
  // static Future<void> _saveDataToCache(
  //   String firstname,
  //   String lastname,
  //   String email,
  // ) async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.setString('firstname', firstname);
  //     await prefs.setString('lastname', lastname);
  //     await prefs.setString('email', email);
  //   } catch (e) {
  //     throw Exception('Something went wrong');
  //   }
  // }

  static FutureOr<HomeModelState?> getInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Response response = await get(
      Uri.parse('http://34.72.136.54:4067/api/v1/auth/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return HomeModelState(
        data['data']['firstname'],
        data['data']['lastname'],
        data['data']['email'],
      );
    } else {
      throw Exception('Something went wrong');
    }
  }
}
