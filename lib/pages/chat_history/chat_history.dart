import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatHistory extends ConsumerWidget {
  const ChatHistory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(child: Center(child: Text("Chat history Page")));
  }
}
