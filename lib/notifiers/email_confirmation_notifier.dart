import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../core/models/email_confirmation_state.dart';

class EmailConfirmationNotifier extends StateNotifier<EmailConfirmationState> {
  EmailConfirmationNotifier(): super(EmailConfirmationState());

  Future<void> submitEmail(String email) async {
    state = state.copyWith(isLoading: true); // Set loading to true
    try {
      final response = await http.post(
        Uri.parse('http://34.72.136.54:4067/api/v1/auth/forget-password'),
        body: {'email': email},
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        state = state.copyWith(isSuccess: true);
      } else {
        state = state.copyWith(error: 'Invalid Email or Password');
      }
    } catch (e) {
      state = state.copyWith(error: 'Error occurred');
    } finally {
      state = state.copyWith(isLoading: false); // Set loading to false
    }
  }
}
