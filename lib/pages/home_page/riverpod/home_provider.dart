import 'package:cheerpup/pages/home_page/riverpod/home_page_notifier.dart';
import 'package:cheerpup/pages/home_page/riverpod/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for the HomePageNotifier
final homePageProvider = StateNotifierProvider<HomePageNotifier, HomeState>((
  ref,
) {
  return HomePageNotifier();
});

// Convenience providers for parts of the HomeState
final userMessagesProvider = Provider<List<Message>>((ref) {
  return ref.watch(homePageProvider).messages;
});

final isLoadingProvider = Provider<bool>((ref) {
  return ref.watch(homePageProvider).isLoading;
});

final suggestedActivitiesProvider = Provider<List<String>>((ref) {
  return ref.watch(homePageProvider).suggestedActivities;
});

final suggestedExercisesProvider = Provider<List<String>>((ref) {
  return ref.watch(homePageProvider).suggestedExercises;
});

final userMoodProvider = Provider<Mood?>((ref) {
  return ref.watch(homePageProvider).mood;
});

final suggestedMusicProvider = Provider<SuggestedMusic?>((ref) {
  return ref.watch(homePageProvider).suggestedMusic;
});
