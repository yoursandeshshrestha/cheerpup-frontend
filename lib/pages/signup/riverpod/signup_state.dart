// lib/pages/signup/riverpod/signup_state.dart

// This file contains the SignupState class, which represents the state of the signup process.
class SignupState {
  final bool isLoading;
  final String? error;
  final String? token;
  final Map<String, dynamic>? userData;

  SignupState({this.isLoading = false, this.error, this.token, this.userData});

  SignupState copyWith({
    bool? isLoading,
    String? error,
    String? token,
    Map<String, dynamic>? userData,
  }) {
    return SignupState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      token: token ?? this.token,
      userData: userData ?? this.userData,
    );
  }

  factory SignupState.initial() {
    return SignupState();
  }
}
