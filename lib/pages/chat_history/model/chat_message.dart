class ChatMessage {
  final String id;
  final String preview;
  final String fullResponse;
  final DateTime? timestamp;

  ChatMessage({
    required this.id,
    required this.preview,
    required this.fullResponse,
    this.timestamp,
  });
}
