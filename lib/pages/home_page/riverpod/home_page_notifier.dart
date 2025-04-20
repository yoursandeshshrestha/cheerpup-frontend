import 'package:cheerpup/commons/models/user_model.dart';
import 'package:cheerpup/commons/services/chat_service.dart';
import 'package:cheerpup/pages/chat_history/model/chat_message.dart';
import 'package:cheerpup/pages/home_page/riverpod/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePageNotifier extends StateNotifier<HomeState> {
  final ChatService _chatService = ChatService();
  final int _messageLimit = 1; // Set the message limit to 1

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

  void updateUserProfileImage(String imageUrl) {
    if (state.currentUser == null) return;

    // Create a new user object with the updated image URL
    final updatedUser = state.currentUser!.copyWith(profileImage: imageUrl);

    // Update the state with the new user
    state = state.copyWith(currentUser: updatedUser);
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

    // Check if user has reached message limit
    if (state.messageCount >= _messageLimit) {
      state = state.copyWith(hasReachedLimit: true);
      return;
    }

    // Add user message
    final userMessage = Message(text: messageText, isUserMessage: true);
    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isLoading: true,
      messageCount: state.messageCount + 1, // Increment message count
    );

    try {
      // Add a placeholder for the pending response
      final pendingMessage = Message(
        text: '',
        isUserMessage: false,
        isPending: true,
      );

      state = state.copyWith(messages: [...state.messages, pendingMessage]);

      // Call the OpenAI service through our API
      final apiResponse = await _chatService.chatWithOpenAI(
        feelingText: messageText,
      );

      // Remove pending message
      final updatedMessages = [...state.messages];
      updatedMessages.removeLast(); // Remove pending message

      if (apiResponse['success'] == true) {
        // Process the successful response
        final data = apiResponse['data'];

        // Extract the AI response
        final responseText =
            data['response'] ?? 'Sorry, I could not understand that.';

        // Extract suggested activities
        final activities = _extractSuggestedActivities(data);

        // Extract suggested exercises
        final exercises = _extractSuggestedExercises(data);

        // Extract mood information
        final moodData = data['mood'];
        Mood? mood;
        if (moodData != null) {
          mood = Mood(
            mood: moodData['mood'] ?? 'Neutral',
            moodRating: moodData['moodRating'] ?? 5,
          );
        }

        // Extract music suggestion
        final musicData = data['suggestedMusicLink'];
        SuggestedMusic? suggestedMusic;
        if (musicData != null) {
          suggestedMusic = SuggestedMusic(
            title: musicData['title'] ?? 'Relaxing Music',
            link: musicData['link'] ?? '',
          );
        }

        // Add AI response message
        final aiMessage = Message(text: responseText, isUserMessage: false);

        // Update state with all new information
        state = state.copyWith(
          messages: [...updatedMessages, aiMessage],
          isLoading: false,
          suggestedActivities: activities,
          suggestedExercises: exercises,
          mood: mood,
          suggestedMusic: suggestedMusic,
          hasReachedLimit: state.messageCount >= _messageLimit,
        );

        // Fetch updated user chat history
        _updateUserChatHistory();
      } else {
        // Handle error response
        final errorMessage = Message(
          text:
              apiResponse['message'] ??
              "Sorry, I couldn't process your request. Please try again.",
          isUserMessage: false,
        );

        state = state.copyWith(
          messages: [...updatedMessages, errorMessage],
          isLoading: false,
          hasReachedLimit: state.messageCount >= _messageLimit,
        );
      }
    } catch (e) {
      // Handle exception - remove pending message and add error message
      final updatedMessages = [...state.messages];
      if (updatedMessages.isNotEmpty) {
        updatedMessages.removeLast(); // Remove pending message
      }

      final errorMessage = Message(
        text:
            "Sorry, I couldn't connect to the service. Please check your connection and try again.",
        isUserMessage: false,
      );

      state = state.copyWith(
        messages: [...updatedMessages, errorMessage],
        isLoading: false,
        hasReachedLimit: state.messageCount >= _messageLimit,
      );
    }
  }

  // Fetch and update user chat history
  Future<void> _updateUserChatHistory() async {
    try {
      // Fetch the chat history
      final response = await _chatService.getUserChatHistory();

      if (response['success'] == true && response['data'] != null) {
        final chatData = response['data'];

        if (chatData['chatHistory'] != null) {
          // Convert the chat history JSON to ChatHistoryModel list
          final chatHistory =
              (chatData['chatHistory'] as List<dynamic>)
                  .map((chat) => ChatHistoryModel.fromJson(chat))
                  .toList();

          // Update the current user with the new chat history
          if (state.currentUser != null) {
            final updatedUser = state.currentUser!.copyWith(
              apiChatHistory: chatHistory,
            );

            // Update state with the updated user
            state = state.copyWith(currentUser: updatedUser);

            print(
              'Chat history updated successfully with ${chatHistory.length} items',
            );
          }
        }
      } else {
        print('Failed to update chat history: ${response['message']}');
      }
    } catch (e) {
      print('Error updating chat history: $e');
    }
  }

  // Extract suggested activities from API response
  List<String> _extractSuggestedActivities(Map<String, dynamic> data) {
    try {
      final activities = data['suggestedActivity'];
      if (activities is List) {
        return List<String>.from(activities);
      }
    } catch (e) {
      print('Error extracting suggested activities: $e');
    }
    return [];
  }

  // Extract suggested exercises from API response
  List<String> _extractSuggestedExercises(Map<String, dynamic> data) {
    try {
      final exercises = data['suggestedExercise'];
      if (exercises is List) {
        return List<String>.from(exercises);
      }
    } catch (e) {
      print('Error extracting suggested exercises: $e');
    }
    return [];
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
