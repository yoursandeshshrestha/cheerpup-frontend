import 'package:cheerpup/pages/chat_history/model/chat_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatHistoryNotifier extends StateNotifier<List<ChatMessage>> {
  ChatHistoryNotifier() : super([]);

  void addChat(ChatMessage message) {
    state = [...state, message];
  }

  ChatMessage? getChatById(String id) {
    return state.firstWhere(
      (msg) => msg.id == id,
      orElse: () => ChatMessage(id: '', preview: '', fullResponse: ''),
    );
  }
}

final chatHistoryProvider =
    StateNotifierProvider<ChatHistoryNotifier, List<ChatMessage>>(
      (ref) => ChatHistoryNotifier(),
    );
