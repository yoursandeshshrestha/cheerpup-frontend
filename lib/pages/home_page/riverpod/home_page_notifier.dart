// lib/pages/home_page/riverpod/home_page_notifier.dart

import 'package:cheerpup/commons/models/user_model.dart';
import 'package:cheerpup/pages/home_page/riverpod/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePageNotifier extends StateNotifier<HomeState> {
  HomePageNotifier() : super(HomeState());

  // Initialize user data from login response
  void initializeUserData(Map<String, dynamic> userData) {
    try {
      // Convert the JSON data to UserModel
      final userModel = UserModel.fromJson(userData);

      state = state.copyWith(currentUser: userModel);

      print('User data initialized successfully: ${userModel.name}');
    } catch (e) {
      print('Error initializing user data: $e');
      // You might want to set a fallback user or show an error message
    }
  }

  // Update user profile
  void updateUserProfile({
    String? name,
    String? email,
    double? weight,
    String? gender,
    String? location,
  }) {
    final updatedUser = state.currentUser?.copyWith(name: name, email: email);

    state = state.copyWith(currentUser: updatedUser);
  }

  // Send message to AI and get response
  Future<void> sendMessageToAI(String messageText) async {
    if (messageText.trim().isEmpty) return;

    // Add user message
    final userMessage = Message(text: messageText, isUserMessage: true);
    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isLoading: true,
    );

    try {
      // Add a placeholder for the pending response
      final pendingMessage = Message(
        text: '',
        isUserMessage: false,
        isPending: true,
      );

      state = state.copyWith(messages: [...state.messages, pendingMessage]);

      // Simulate API call - Replace with actual API call
      final response = await _callAIService(messageText);

      // Generate suggestions based on the message
      final activities = _generateSuggestedActivities(messageText);
      final exercises = _generateSuggestedExercises(messageText);

      // Remove pending message and add actual response
      final updatedMessages = [...state.messages];
      updatedMessages.removeLast(); // Remove pending message

      final aiMessage = Message(text: response, isUserMessage: false);

      state = state.copyWith(
        messages: [...updatedMessages, aiMessage],
        isLoading: false,
        suggestedActivities: activities,
        suggestedExercises: exercises,
      );
    } catch (e) {
      // Handle error - remove pending message and add error message
      final updatedMessages = [...state.messages];
      updatedMessages.removeLast(); // Remove pending message

      final errorMessage = Message(
        text: "Sorry, I couldn't process your request. Please try again.",
        isUserMessage: false,
      );

      state = state.copyWith(
        messages: [...updatedMessages, errorMessage],
        isLoading: false,
      );
    }
  }

  // Mock AI service call - replace with actual implementation
  Future<String> _callAIService(String message) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock response based on user message
    if (message.toLowerCase().contains('exercise') ||
        message.toLowerCase().contains('workout')) {
      return "I recommend starting with light exercises like walking or stretching. What are your fitness goals?";
    } else if (message.toLowerCase().contains('sad') ||
        message.toLowerCase().contains('depress')) {
      return "I'm sorry to hear you're feeling down. Would you like to try some mood-boosting activities?";
    } else if (message.toLowerCase().contains('happy') ||
        message.toLowerCase().contains('good')) {
      return "That's great! Let's keep that positive energy going with some fulfilling activities!";
    } else {
      return "Thanks for sharing! How are you feeling today? I can suggest some activities to help with your well-being.";
    }
  }

  // Generate suggested activities based on message content
  List<String> _generateSuggestedActivities(String message) {
    // This would typically come from your AI service in a real app
    // For now, we'll return mock data based on message content
    if (message.toLowerCase().contains('stress') ||
        message.toLowerCase().contains('anxious')) {
      return [
        'Deep Breathing: 5-minute breathing exercise to reduce stress',
        'Nature Walk: Take a 15-minute walk in a park or natural setting',
      ];
    } else if (message.toLowerCase().contains('sleep') ||
        message.toLowerCase().contains('tired')) {
      return [
        'Bedtime Routine: Create a calming pre-sleep ritual',
        'Screen-Free Hour: Avoid screens 1 hour before bed',
      ];
    } else {
      return state.suggestedActivities; // Keep existing suggestions
    }
  }

  // Generate suggested exercises based on message content
  List<String> _generateSuggestedExercises(String message) {
    // This would typically come from your AI service in a real app
    if (message.toLowerCase().contains('fitness') ||
        message.toLowerCase().contains('exercise')) {
      return [
        'Morning Stretches: 10-minute full-body stretch routine',
        'Quick HIIT: 7-minute high-intensity interval training',
      ];
    } else {
      return state.suggestedExercises; // Keep existing suggestions
    }
  }

  // Toggle activity in list
  void toggleActivity(String activity, bool isExercise) {
    if (isExercise) {
      // For exercises, we'll remove it if it exists or add it if not
      final updatedExercises = List<String>.from(state.suggestedExercises);
      if (updatedExercises.contains(activity)) {
        updatedExercises.remove(activity);
      } else {
        updatedExercises.add(activity);
      }
      state = state.copyWith(suggestedExercises: updatedExercises);
    } else {
      // For activities, we'll remove it if it exists or add it if not
      final updatedActivities = List<String>.from(state.suggestedActivities);
      if (updatedActivities.contains(activity)) {
        updatedActivities.remove(activity);
      } else {
        updatedActivities.add(activity);
      }
      state = state.copyWith(suggestedActivities: updatedActivities);
    }
  }
}
