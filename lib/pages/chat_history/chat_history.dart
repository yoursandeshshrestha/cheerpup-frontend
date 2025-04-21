import 'package:cheerpup/pages/chat_history/widgets/chat_history_tile.dart';
import 'package:cheerpup/pages/home_page/riverpod/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatHistory extends ConsumerWidget {
  const ChatHistory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    final messages = homeState.currentUser!.apiChatHistory;

    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return ChatHistoryTile(message: messages[index]);
      },
    );
  }
}
