import 'package:cheerpup/commons/entities/user.dart';

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

class HomeState {
  final User? currentUser;
  final List<Message> messages;
  final bool isLoading;
  final List<String> suggestedActivities;
  final List<String> suggestedExercises;

  HomeState({
    this.currentUser,
    List<Message>? messages,
    this.isLoading = false,
    List<String>? suggestedActivities,
    List<String>? suggestedExercises,
  }) : messages = messages ?? [],
       suggestedActivities = suggestedActivities ?? [],
       suggestedExercises = suggestedExercises ?? [];

  // Create a copy of the current state with updated values
  HomeState copyWith({
    User? currentUser,
    List<Message>? messages,
    bool? isLoading,
    List<String>? suggestedActivities,
    List<String>? suggestedExercises,
  }) {
    return HomeState(
      currentUser: currentUser ?? this.currentUser,
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      suggestedActivities: suggestedActivities ?? this.suggestedActivities,
      suggestedExercises: suggestedExercises ?? this.suggestedExercises,
    );
  }
}
