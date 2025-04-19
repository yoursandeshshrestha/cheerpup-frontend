// lib/pages/signup/riverpod/signup_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cheerpup/pages/signup/riverpod/signup_notifier.dart';
import 'package:cheerpup/pages/signup/riverpod/signup_state.dart';

final signupProvider = StateNotifierProvider<SignupNotifier, SignupState>((
  ref,
) {
  return SignupNotifier(ref);
});
