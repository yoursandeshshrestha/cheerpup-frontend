import 'package:cheerpup/pages/chat_history/model/chat_message.dart';
import 'package:flutter/material.dart';
import '../screens/chat_detail_screen.dart';

// New parent widget to manage the Chat History screen
class ChatHistoryScreen extends StatelessWidget {
  final List<ChatHistoryModel> messages;

  const ChatHistoryScreen({Key? key, required this.messages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Modern header with gradient and animated design
          SliverAppBar(
            expandedHeight: 170,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: Theme.of(context).primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                "Chat History",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  letterSpacing: 0.5,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 3.0,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Gradient background
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.deepPurple.shade800,
                          Colors.deepPurple.shade500,
                        ],
                      ),
                    ),
                  ),
                  // Decorative elements
                  Positioned(
                    top: -20,
                    right: -20,
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 30,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  // Icon
                  Positioned(
                    top: 70,
                    right: 20,
                    child: Icon(
                      Icons.chat_bubble_outline,
                      size: 36,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  // Search functionality
                },
              ),
              IconButton(
                icon: const Icon(Icons.filter_list, color: Colors.white),
                onPressed: () {
                  // Filter functionality
                },
              ),
              const SizedBox(width: 8),
            ],
          ),

          // Today section header
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverHeaderDelegate(
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Today",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple.shade800,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "${messages.length} conversations",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Chat list
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return ChatHistoryTile(message: messages[index]);
            }, childCount: messages.length),
          ),

          // Bottom padding
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
      // Float Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Start new chat
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Sliver persistent header delegate
class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _SliverHeaderDelegate({required this.child, this.height = 50.0});

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox(height: height, child: child);
  }

  @override
  bool shouldRebuild(_SliverHeaderDelegate oldDelegate) {
    return oldDelegate.height != height || oldDelegate.child != child;
  }
}

class ChatHistoryTile extends StatelessWidget {
  final ChatHistoryModel message;

  const ChatHistoryTile({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    // Get a random pastel color based on the message ID to make avatars unique
    final Color avatarColor = _getAvatarColor(message.id);
    final bool hasActivities =
        (message.suggestedActivity != null &&
            message.suggestedActivity!.isNotEmpty);
    final bool hasExercises =
        (message.suggestedExercise != null &&
            message.suggestedExercise!.isNotEmpty);
    final bool hasMusic =
        message.suggestedMusicLinks.isNotEmpty ||
        message.suggestedMusicLink != null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () => _showChatDetailPopup(context, message.id),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 3),
                spreadRadius: 1,
              ),
            ],
            border: Border.all(color: Colors.grey.withOpacity(0.1), width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row with avatar and main info
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar with animated gradient
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            avatarColor,
                            HSLColor.fromColor(avatarColor)
                                .withLightness(
                                  HSLColor.fromColor(avatarColor).lightness *
                                      0.8,
                                )
                                .toColor(),
                          ],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: avatarColor.withOpacity(0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                    ),

                    const SizedBox(width: 14),

                    // Message preview and timestamp
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Title with truncated response
                          Text(
                            message.systemMessage,
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),

                          // Timestamp would go here
                          const SizedBox(height: 4),

                          // User message preview
                          Text(
                            message.userMessage,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Tags/Indicators for content types
                if (hasActivities || hasExercises || hasMusic) ...[
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        if (hasExercises)
                          _buildTag(
                            context,
                            "Exercises",
                            Colors.orange,
                            Icons.fitness_center,
                          ),
                        if (hasActivities)
                          _buildTag(
                            context,
                            "Activities",
                            Colors.green,
                            Icons.directions_run,
                          ),
                        if (hasMusic)
                          _buildTag(
                            context,
                            "Music",
                            Colors.deepPurple,
                            Icons.music_note,
                          ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTag(
    BuildContext context,
    String label,
    Color color,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
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
              return ChatDetailScreen(chat: message, chatId: chatId);
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
