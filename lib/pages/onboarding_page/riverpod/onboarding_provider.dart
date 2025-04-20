// lib/pages/onboarding_page/riverpod/onboarding_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cheerpup/pages/onboarding_page/riverpod/onboarding_notifier.dart';
import 'package:cheerpup/pages/onboarding_page/riverpod/onboarding_state.dart';

final onboardingProvider = StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
  return OnboardingNotifier(ref);
});