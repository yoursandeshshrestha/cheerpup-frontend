import 'package:cheerpup/pages/home_page/riverpod/home_page_notifier.dart';
import 'package:cheerpup/pages/home_page/riverpod/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This file contains the provider for the HomePage widget.
final homeProvider = StateNotifierProvider<HomePageNotifier, HomeState>((ref) {
  return HomePageNotifier();
});
