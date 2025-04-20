// lib/pages/signup/riverpod/signup_notifier.dart

import 'package:cheerpup/commons/models/dto/create_user_dto.dart';
import 'package:cheerpup/commons/services/auth_service.dart';
import 'package:cheerpup/pages/home_page/riverpod/home_provider.dart';
import 'package:cheerpup/pages/signup/riverpod/signup_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupNotifier extends StateNotifier<SignupState> {
  final Ref _ref;

  SignupNotifier(this._ref) : super(SignupState.initial());

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

      // Use AuthService to handle signup
      final authService = _ref.read(authServiceProvider);
      final result = await authService.signup(createUserDto);

      if (result['success']) {
        // Get userData and token from AuthService
        final userData = authService.userData;
        final token = authService.token;

        // Initialize home page state with user data
        if (userData != null) {
          _ref.read(homePageProvider.notifier).initializeUserData(userData);
        }

        // Update state with success data
        state = state.copyWith(
          isLoading: false,
          token: token,
          userData: userData,
        );

        print('Signup successful for user: ${userData?['name']}');
      } else {
        // Handle signup error
        final errorMessage =
            result['message'] ?? 'Failed to sign up. Please try again.';
        state = state.copyWith(isLoading: false, error: errorMessage);

        print('Signup failed: $errorMessage');
      }
    } catch (e) {
      // Handle unexpected exceptions
      state = state.copyWith(
        isLoading: false,
        error:
            'An error occurred. Please check your internet connection and try again.',
      );

      print('Signup exception: $e');
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
