import 'package:cheerpup/pages/home_page/riverpod/home_page_notifier.dart';
import 'package:cheerpup/pages/home_page/riverpod/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = StateNotifierProvider<HomePageNotifier, HomeState>((ref) {
  return HomePageNotifier();
});
