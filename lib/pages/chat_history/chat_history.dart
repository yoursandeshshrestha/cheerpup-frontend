// import 'package:cheerpup/pages/chat_history/providers/chat_history_provider.dart';
// import 'package:cheerpup/pages/chat_history/widgets/chat_history_tile.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class ChatHistory extends ConsumerWidget {
//   const ChatHistory({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final messages = ref.watch(chatHistoryProvider);

//     return ListView.builder(
//       itemCount: messages.length,
//       itemBuilder: (context, index) {
//         return ChatHistoryTile(message: messages[index]);
//       },
//     );
//   }
// }


import 'package:cheerpup/pages/chat_history/model/chat_message.dart';
import 'package:cheerpup/pages/chat_history/providers/chat_history_provider.dart';
import 'package:cheerpup/pages/chat_history/widgets/chat_history_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatHistory extends ConsumerStatefulWidget {
  const ChatHistory({super.key});

  @override
  ConsumerState<ChatHistory> createState() => _ChatHistoryListState();
}

class _ChatHistoryListState extends ConsumerState<ChatHistory> {
  @override
  void initState() {
    super.initState();

    final notifier = ref.read(chatHistoryProvider.notifier);

    // Load dummy data only once
    if (ref.read(chatHistoryProvider).isEmpty) {
      notifier.addChat(
        ChatMessage(
          id: '1',
          preview: 'Hello, how can I help you today?',
          fullResponse:
              'Hello! I am your AI assistant. How can I help you today?',
        ),
      );

      notifier.addChat(
        ChatMessage(
          id: '2',
          preview: 'What is the weather like?',
          fullResponse:
              'The weather today is sunny with a high of 25°C and low of 15°C.',
        ),
      );

      notifier.addChat(
        ChatMessage(
          id: '3',
          preview: 'Tell me a joke',
          fullResponse:
              'Why don’t skeletons fight each other? They don’t have the guts.',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatHistoryProvider);

    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return ChatHistoryTile(message: messages[index]);
      },
    );
  }
}
