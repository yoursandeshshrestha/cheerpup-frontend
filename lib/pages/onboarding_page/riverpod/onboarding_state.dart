// lib/pages/onboarding_page/riverpod/onboarding_state.dart

class OnboardingState {
  final bool isLoading;
  final bool isCompleted;
  final String? error;
  final Map<String, dynamic>? userData;

  OnboardingState({
    this.isLoading = false,
    this.isCompleted = false,
    this.error,
    this.userData,
  });

  OnboardingState copyWith({
    bool? isLoading,
    bool? isCompleted,
    String? error,
    Map<String, dynamic>? userData,
  }) {
    return OnboardingState(
      isLoading: isLoading ?? this.isLoading,
      isCompleted: isCompleted ?? this.isCompleted,
      error: error,
      userData: userData ?? this.userData,
    );
  }

  factory OnboardingState.initial() {
    return OnboardingState();
  }
}