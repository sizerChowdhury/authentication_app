
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutRepository {
  static FutureOr<bool?> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Response response = await post(
      Uri.parse("http://34.72.136.54:4067/api/v1/auth/logout"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode != 201) {
      throw Exception('Something went wrong');
    } else {
      prefs.clear();
      return true;
    }
  }
}

// body: SafeArea(
// child: Padding(
// padding: const EdgeInsets.all(24.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// ProfilePictureHolder(image: Assets.profile.provider()),
// const SizedBox(height: 20),
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// (flag)
// ? const CircularProgressIndicator()
//     : Column(
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Text(
// 'Name: ${state.value?.getFirstName()} ${state.value?.getLastName()}'),
// Text(
// 'Email: ${state.value?.getEmail()}',
// ),
// ],
// ),
// ],
// ),
// const Spacer(),
// TextButton(
// onPressed: () {
// ref.read(logoutControllerProvider.notifier).signOut();
// },
// child: (logoutFlag.isLoading)? const CircularProgressIndicator(): const Text('Logout')),
// ],
// ),
// ),
// ),
