// lib/pages/signup/riverpod/signup_notifier.dart

import 'package:cheerpup/commons/models/dto/create_user_dto.dart';
import 'package:cheerpup/commons/services/user_service.dart';
import 'package:cheerpup/pages/signup/riverpod/signup_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupNotifier extends StateNotifier<SignupState> {
  final UserService _userService = UserService();

  SignupNotifier() : super(SignupState.initial());

  Future<void> signup({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      // Set loading state
      state = state.copyWith(isLoading: true, error: null);

      // Create DTO for signup
      final createUserDto = CreateUserDto(
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
      );

      // Call user service to create user
      final result = await _userService.createUser(createUserDto);

      if (result['success']) {
        // Extract data from successful response
        final responseData = result['data'];
        final token = responseData['token'];
        final userData = responseData['user'];

        // Save token to shared preferences for persistent login
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);

        // Update state with success data
        state = state.copyWith(
          isLoading: false,
          token: token,
          userData: userData,
        );
      } else {
        // Handle signup error
        final errorMessage =
            result['message'] ?? 'Failed to sign up. Please try again.';
        state = state.copyWith(isLoading: false, error: errorMessage);
      }
    } catch (e) {
      // Handle unexpected exceptions
      state = state.copyWith(
        isLoading: false,
        error:
            'An error occurred. Please check your internet connection and try again.',
      );
    }
  }

  // Clear signup errors (useful when navigating away from signup page)
  void clearErrors() {
    state = state.copyWith(error: null);
  }

  // Reset the entire state (useful for logout)
  void resetState() {
    state = SignupState.initial();
  }
}
