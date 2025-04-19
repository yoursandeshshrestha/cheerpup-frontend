// lib/pages/login/riverpod/login_notifier.dart

import 'package:cheerpup/commons/models/dto/login_user.dto.dart';
import 'package:cheerpup/commons/services/auth_service.dart';
import 'package:cheerpup/pages/home_page/riverpod/home_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cheerpup/pages/login/riverpod/login_state.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  final Ref _ref;

  LoginNotifier(this._ref) : super(LoginState.initial());

  Future<void> login({
    required String identifier,
    required String password,
  }) async {
    try {
      // Set loading state
      state = state.copyWith(isLoading: true, error: null);

      // Create DTO for login
      final loginUserDto = LoginUserDto(
        identifier: identifier,
        password: password,
      );

      // Use AuthService to handle login
      final authService = _ref.read(authServiceProvider);
      final result = await authService.login(loginUserDto);

      if (result['success']) {
        // Get userData and token from AuthService
        final userData = authService.userData;
        final token = authService.token;

        // Initialize home page state with user data
        if (userData != null) {
          _ref.read(homeProvider.notifier).initializeUserData(userData);
        }

        // Update state with success data
        state = state.copyWith(
          isLoading: false,
          token: token,
          userData: userData,
        );

        print('Login successful for user: ${userData?['name']}');
      } else {
        // Handle login error
        final errorMessage =
            result['message'] ?? 'Failed to log in. Please try again.';
        state = state.copyWith(isLoading: false, error: errorMessage);

        print('Login failed: $errorMessage');
      }
    } catch (e) {
      // Handle unexpected exceptions
      final errorMessage =
          'An error occurred. Please check your internet connection and try again.';
      state = state.copyWith(isLoading: false, error: errorMessage);

      print('Login exception: $e');
    }
  }

  // Clear login errors (useful when navigating away from login page)
  void clearErrors() {
    state = state.copyWith(error: null);
  }

  // Reset the entire state (useful for logout)
  void resetState() {
    state = LoginState.initial();
  }
}
