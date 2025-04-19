import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInState {
  final bool isLoading;
  final String? error;

  SignInState({this.isLoading = false, this.error});
}

class SignInNotifier extends StateNotifier<SignInState> {
  SignInNotifier() : super(SignInState());

  Future<void> signIn(String email, String password) async {
    state = SignInState(isLoading: true);
    try {
      await Future.delayed(const Duration(seconds: 2)); // simulate login
      // If success:
      state = SignInState();
    } catch (e) {
      state = SignInState(error: 'Failed to sign in');
    }
  }
}

final signInProvider = StateNotifierProvider<SignInNotifier, SignInState>(
  (ref) => SignInNotifier(),
);
