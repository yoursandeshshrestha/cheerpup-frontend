import 'package:cheerpup/commons/models/user_model.dart';

class Message {
  final String text;
  final bool isUserMessage;
  final bool isPending;
  final DateTime timestamp;

  Message({
    required this.text,
    required this.isUserMessage,
    this.isPending = false,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class Mood {
  final String mood;
  final int moodRating;

  Mood({required this.mood, required this.moodRating});
}

class SuggestedMusic {
  final String title;
  final String link;

  SuggestedMusic({required this.title, required this.link});
}

class HomeState {
  final UserModel? currentUser;
  final List<Message> messages;
  final bool isLoading;
  final List<String> suggestedActivities;
  final List<String> suggestedExercises;
  final Mood? mood;
  final SuggestedMusic? suggestedMusic;
  final int messageCount; // Track number of messages sent
  final bool hasReachedLimit; // Flag to indicate if user has reached the limit

  HomeState({
    this.currentUser,
    List<Message>? messages,
    this.isLoading = false,
    List<String>? suggestedActivities,
    List<String>? suggestedExercises,
    this.mood,
    this.suggestedMusic,
    this.messageCount = 0,
    this.hasReachedLimit = false,
  }) : messages = messages ?? [],
       suggestedActivities = suggestedActivities ?? [],
       suggestedExercises = suggestedExercises ?? [];

  // Create a copy of the current state with updated values
  HomeState copyWith({
    UserModel? currentUser,
    List<Message>? messages,
    bool? isLoading,
    List<String>? suggestedActivities,
    List<String>? suggestedExercises,
    Mood? mood,
    SuggestedMusic? suggestedMusic,
    int? messageCount,
    bool? hasReachedLimit,
  }) {
    return HomeState(
      currentUser: currentUser ?? this.currentUser,
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      suggestedActivities: suggestedActivities ?? this.suggestedActivities,
      suggestedExercises: suggestedExercises ?? this.suggestedExercises,
      mood: mood ?? this.mood,
      suggestedMusic: suggestedMusic ?? this.suggestedMusic,
      messageCount: messageCount ?? this.messageCount,
      hasReachedLimit: hasReachedLimit ?? this.hasReachedLimit,
    );
  }
}
