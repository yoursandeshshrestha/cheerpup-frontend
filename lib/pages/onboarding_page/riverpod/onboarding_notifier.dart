// lib/pages/onboarding_page/riverpod/onboarding_notifier.dart

import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cheerpup/commons/models/dto/update_user_dto.dart';
import 'package:cheerpup/commons/services/auth_service.dart';
import 'package:cheerpup/commons/services/user_service.dart';
import 'package:cheerpup/pages/onboarding_page/riverpod/onboarding_state.dart';

class OnboardingNotifier extends StateNotifier<OnboardingState> {
  final Ref _ref;
  final UserService _userService = UserService();

  OnboardingNotifier(this._ref) : super(OnboardingState.initial());

  // Complete the onboarding process by submitting data to API
  Future<void> completeOnboarding({
    required File? profileImage,
    required int? age,
    required String? gender,
    required bool? isPhysicalHelpBefore,
    required bool isPhysicalDistress,
    required List<String> medicines,
  }) async {
    try {
      // Set loading state
      state = state.copyWith(isLoading: true, error: null);

      // Get user ID from auth service
      final authService = _ref.read(authServiceProvider);
      final userId = await authService.getUserId();

      if (userId == null) {
        state = state.copyWith(
          isLoading: false,
          error: 'User not authenticated',
        );
        return;
      }

      // Create DTO for profile update
      final updateUserDto = UpdateUserDto(
        age: age,
        gender: gender,
        isPhysicalHelpBefore: isPhysicalHelpBefore,
        isPhysicalDistress: isPhysicalDistress,
        medicines: medicines.isNotEmpty ? medicines : null,
      );

      // Submit data to API
      final result = await _userService.updateUserProfile(
        userId: userId,
        updateUserDto: updateUserDto,
        profileImage: profileImage,
      );

      if (result['success']) {
        // Get updated user data
        final userData = result['data']['user'];

        // Update state with success data
        state = state.copyWith(
          isLoading: false,
          isCompleted: true,
          userData: userData,
        );

        print('Onboarding completed successfully for user: ${userData['name']}');
      } else {
        // Handle error
        final errorMessage = result['message'] ?? 'Failed to update profile. Please try again.';
        state = state.copyWith(isLoading: false, error: errorMessage);

        print('Onboarding update failed: $errorMessage');
      }
    } catch (e) {
      // Handle unexpected exceptions
      state = state.copyWith(
        isLoading: false,
        error: 'An error occurred. Please check your internet connection and try again.',
      );

      print('Onboarding exception: $e');
    }
  }

  // Reset the state when needed
  void resetState() {
    state = OnboardingState.initial();
  }

  // Clear errors
  void clearErrors() {
    state = state.copyWith(error: null);
  }
}