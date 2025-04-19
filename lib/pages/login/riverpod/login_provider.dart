// lib/pages/login/riverpod/login_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cheerpup/pages/login/riverpod/login_notifier.dart';
import 'package:cheerpup/pages/login/riverpod/login_state.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier(ref);
});
