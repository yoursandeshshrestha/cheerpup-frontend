// lib/pages/login/riverpod/login_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cheerpup/pages/login/riverpod/login_notifier.dart';
import 'package:cheerpup/pages/login/riverpod/login_state.dart';

// This file contains the provider for the LoginPage widget.
final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier(ref);
});
