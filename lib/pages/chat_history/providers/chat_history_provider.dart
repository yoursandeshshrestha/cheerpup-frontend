// import 'package:cheerpup/pages/chat_history/model/chat_message.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class ChatHistoryNotifier extends StateNotifier<List<ChatHistoryModel>> {
//   ChatHistoryNotifier() : super([]);

//   void addChat(ChatHistoryModel message) {
//     state = [...state, message];
//   }

//   ChatHistoryModel? getChatById(String id) {
//     return state.firstWhere(
//       (msg) => msg.id == id,
//       orElse:
//           () => ChatHistoryModel(
//             id: '',

//             userMessage: '',
//             systemMessage: '',
//             suggestedMusicLinks: [],
//           ),
//     );
//   }
// }

// final chatHistoryProvider =
//     StateNotifierProvider<ChatHistoryNotifier, List<ChatHistoryModel>>(
//       (ref) => ChatHistoryNotifier(),
//     );
