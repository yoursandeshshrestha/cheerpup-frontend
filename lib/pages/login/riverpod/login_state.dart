// lib/pages/login/riverpod/login_state.dart

// This file contains the state class for the LoginPage widget.
// It defines the properties that represent the state of the login process.
class LoginState {
  final bool isLoading;
  final String? error;
  final String? token;
  final Map<String, dynamic>? userData;

  LoginState({this.isLoading = false, this.error, this.token, this.userData});

  LoginState copyWith({
    bool? isLoading,
    String? error,
    String? token,
    Map<String, dynamic>? userData,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      token: token ?? this.token,
      userData: userData ?? this.userData,
    );
  }

  factory LoginState.initial() {
    return LoginState();
  }
}
