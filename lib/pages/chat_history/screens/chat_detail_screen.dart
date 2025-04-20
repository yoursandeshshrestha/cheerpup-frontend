import 'package:cheerpup/pages/chat_history/model/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:cheerpup/commons/models/user_model.dart'; // contains MusicLinkModel

class ChatDetailScreen extends StatelessWidget {
  final ChatHistoryModel chat;
  final String chatId;

  const ChatDetailScreen({super.key, required this.chat, required this.chatId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Modern app bar with gradient and hero image
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Chat Details",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 3.0,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.deepPurple.shade800,
                      Colors.deepPurple.shade500,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 50,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.chat_bubble_outline_rounded,
                      size: 80,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share_outlined, color: Colors.white),
                onPressed: () {
                  // Share functionality
                },
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {
                  // More options
                },
              ),
            ],
          ),

          // Main content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User message card
                  _buildSectionCard(
                    context,
                    title: "User Message",
                    icon: Icons.person_outline,
                    iconColor: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        chat.userMessage.isNotEmpty
                            ? chat.userMessage
                            : "No message",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // System message card
                  _buildSectionCard(
                    context,
                    title: "System Message",
                    icon: Icons.smart_toy_outlined,
                    iconColor: Colors.deepPurple,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        chat.systemMessage.isNotEmpty
                            ? chat.systemMessage
                            : "No system message",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),

                  // Suggested exercises
                  if (chat.suggestedExercise != null &&
                      chat.suggestedExercise!.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _buildSectionCard(
                      context,
                      title: "Suggested Exercises",
                      icon: Icons.fitness_center,
                      iconColor: Colors.orange,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              chat.suggestedExercise!.map((e) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Colors.orange.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.directions_run,
                                          size: 18,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          e,
                                          style:
                                              Theme.of(
                                                context,
                                              ).textTheme.bodyMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                    ),
                  ],

                  // Suggested activities
                  if (chat.suggestedActivity != null &&
                      chat.suggestedActivity!.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _buildSectionCard(
                      context,
                      title: "Suggested Activities",
                      icon: Icons.hiking_outlined,
                      iconColor: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              chat.suggestedActivity!.map((a) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Colors.green.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.local_activity_outlined,
                                          size: 18,
                                          color: Colors.green,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          a,
                                          style:
                                              Theme.of(
                                                context,
                                              ).textTheme.bodyMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                    ),
                  ],

                  // Suggested music links
                  if (chat.suggestedMusicLinks.isNotEmpty &&
                      chat.suggestedMusicLinks.any(
                        (link) => link.link != null,
                      )) ...[
                    const SizedBox(height: 16),
                    _buildSectionCard(
                      context,
                      title: "Suggested Music Links",
                      icon: Icons.library_music_outlined,
                      iconColor: Colors.pinkAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              chat.suggestedMusicLinks
                                  .where(
                                    (link) => link.link != null,
                                  ) // Only include links that are not null
                                  .map((m) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 12.0,
                                      ),
                                      child: _buildMusicLinkItem(context, m),
                                    );
                                  })
                                  .toList(),
                        ),
                      ),
                    ),
                  ],

                  // Top music recommendation
                  if (chat.suggestedMusicLink != null) ...[
                    const SizedBox(height: 16),
                    _buildSectionCard(
                      context,
                      title: "Top Music Recommendation",
                      icon: Icons.star_border_rounded,
                      iconColor: Colors.amber,
                      accentColor: Colors.deepPurple,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.deepPurple.withOpacity(0.1),
                                Colors.deepPurple.withOpacity(0.05),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.deepPurple.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: const Icon(
                                  Icons.music_note,
                                  color: Colors.deepPurple,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Recommended Track",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(color: Colors.deepPurple),
                                    ),
                                    const SizedBox(height: 4),
                                    InkWell(
                                      onTap: () {
                                        // Handle null link safely
                                        if (chat.suggestedMusicLink?.link !=
                                            null) {
                                          // Open URL
                                        }
                                      },
                                      child: Text(
                                        chat.suggestedMusicLink?.link
                                                ?.toString() ??
                                            "No link available",
                                        style: const TextStyle(
                                          color: Colors.deepPurple,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (chat.suggestedMusicLink?.link != null)
                                const Icon(
                                  Icons.open_in_new,
                                  color: Colors.deepPurple,
                                  size: 20,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],

                  // Bottom padding
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text("Back to Chat History"),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget child,
    Color iconColor = Colors.blue,
    Color accentColor = Colors.transparent,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.withOpacity(0.1),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: iconColor, size: 22),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // Card content
          child,
        ],
      ),
    );
  }

  Widget _buildMusicLinkItem(BuildContext context, MusicLinkModel music) {
    return InkWell(
      onTap: () {
        // Only handle tap if link is not null
        if (music.link != null) {
          // Open URL
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.pink.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.music_note,
              size: 20,
              color: Colors.pinkAccent,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  music.link?.toString() ?? "No link available",
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (music.title != null && music.title!.isNotEmpty)
                  Text(
                    music.title!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
              ],
            ),
          ),
          if (music.link != null)
            const Icon(Icons.open_in_new, color: Colors.grey, size: 16),
        ],
      ),
    );
  }
}
