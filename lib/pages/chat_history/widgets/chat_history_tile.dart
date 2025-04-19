import 'package:cheerpup/pages/chat_history/model/chat_message.dart';
import 'package:flutter/material.dart';
import '../screens/chat_detail_screen.dart';

class ChatHistoryTile extends StatelessWidget {
  final ChatMessage message;

  const ChatHistoryTile({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    // Get a random pastel color based on the message ID to make avatars unique
    final Color avatarColor = _getAvatarColor(message.id);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () => _showChatDetailPopup(context, message.id),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar or icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: avatarColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Message preview and timestamp
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title and timestamp in separate rows to prevent overflow
                      Flexible(
                        child: Text(
                          message.fullResponse ?? 'Chat ${message.id.substring(0, 4)}',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      if (message.timestamp != null)
                        Text(
                          _formatTimestamp(message.timestamp!),
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                        ),

                      const SizedBox(height: 4),

                      // Message preview text
                      Text(
                        message.preview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showChatDetailPopup(BuildContext context, String chatId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder: (_, scrollController) {
              return ChatDetailScreen(
                chatId: chatId,
              );
            },
          ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(
      timestamp.year,
      timestamp.month,
      timestamp.day,
    );

    if (messageDate == today) {
      // Today - show time only
      return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      // Yesterday
      return 'Yesterday';
    } else if (now.difference(messageDate).inDays < 7) {
      // Within the last week - show day name
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return days[timestamp.weekday - 1];
    } else {
      // Older than a week - show date
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }

  Color _getAvatarColor(String id) {
    // Generate a pastel color based on the message ID
    final int hashCode = id.hashCode;
    final List<Color> colors = [
      const Color(0xFFFFCDD2), // Pastel red
      const Color(0xFFE1BEE7), // Pastel purple
      const Color(0xFFBBDEFB), // Pastel blue
      const Color(0xFFC8E6C9), // Pastel green
      const Color(0xFFFFE0B2), // Pastel orange
      const Color(0xFFB2DFDB), // Pastel teal
    ];

    return colors[hashCode.abs() % colors.length];
  }
}
