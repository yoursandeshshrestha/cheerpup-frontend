import 'package:cheerpup/commons/models/user_model.dart';
import 'package:cheerpup/commons/utils.dart';
import 'package:cheerpup/pages/home_page/riverpod/home_provider.dart';
import 'package:cheerpup/pages/layout/layout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';


// This file contains the HomeHero widget, which is the header section of the home page.
class HomeHero extends ConsumerStatefulWidget {
  const HomeHero({super.key});

  @override
  ConsumerState<HomeHero> createState() => _HomeHeroState();
}

class _HomeHeroState extends ConsumerState<HomeHero> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _handleSendMessage() {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    ref.read(homeProvider.notifier).sendMessageToAI(message);

    _messageController.clear();
  }

/// This method is called when the user taps the send button
  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);
    final user = homeState.currentUser;
    final isLoading = homeState.isLoading;

    final now = DateTime.now();
    final dateFormat = DateFormat('EEE, dd MMM yyyy');
    final formattedDate = dateFormat.format(now);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      decoration: const BoxDecoration(
        color: Color(0xFF694E3E),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDateHeader(formattedDate),
          const SizedBox(height: 16),
          GestureDetector(
            child: _buildUserDetails(user),
            onTap: () {
              context.goNamed('profile');
              ref.read(navigationIndexProvider.notifier).state = 3;
            },
          ),
          const SizedBox(height: 16),
          _buildInputField(isLoading),
        ],
      ),
    );
  }

  // Widget to build the date header
  // This widget displays the current date in a formatted manner

  Widget _buildDateHeader(String formattedDate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.calendar_today_rounded,
              color: Color(0xFFD2B48C), // Light brown icon color
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              formattedDate,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

// Widget to build the user details section
  // This widget displays the user's profile image and name
  Widget _buildUserDetails(UserModel? user) {
    return Row(
      children: [
        _buildProfileImage(user),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user != null
                  ? 'Hi, ${(user.name).split(' ').first}!'
                  : 'Hi there!',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            _buildUserStats(user),
          ],
        ),
      ],
    );
  }

  // Widget to build the profile image
  Widget _buildProfileImage(UserModel? user) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.2),
        border: Border.all(color: Colors.white, width: 2),
        image:
            user?.profileImage != null
                ? DecorationImage(
                  image: NetworkImage(user!.profileImage!),
                  fit: BoxFit.cover,
                )
                : null,
      ),
      child:
          user?.profileImage == null
              ? const Center(
                child: Icon(Icons.person, color: Colors.white, size: 30),
              )
              : null,
    );
  }

  // Widget to build the user stats row (badges)
  Widget _buildUserStats(UserModel? user) {
    return Row(
      children: [
        // Pro badge - show only if user is subscribed
        // if (user?.isSubscribed == true) ...[
        //   _buildProBadge(),
        //   const SizedBox(width: 8),
        // ],

        // Progress indicator
        // if (user != null) _buildProgressIndicator(user),
        const SizedBox(width: 8),

        // Mood indicator
        if (user != null && user.moods.isNotEmpty) _buildMoodIndicator(user),
      ],
    );
  }

  // Widget to build the Pro badge
  // Widget _buildProBadge() {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
  //     decoration: BoxDecoration(
  //       color: Colors.green,
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: const Row(
  //       children: [
  //         Icon(Icons.star, color: Colors.white, size: 14),
  //         SizedBox(width: 4),
  //         Text(
  //           'Pro',
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontSize: 12,
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget to build the progress indicator
  // Widget _buildProgressIndicator(UserModel user) {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
  //     decoration: BoxDecoration(
  //       color: Colors.orange,
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: Row(
  //       children: [
  //         const Icon(Icons.auto_awesome, color: Colors.white, size: 14),
  //         const SizedBox(width: 4),
  //         Text(
  //           '${user.progressPercentage.toInt()}%',
  //           style: const TextStyle(
  //             color: Colors.white,
  //             fontSize: 12,
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

// Widget to build the mood indicator
  Widget _buildMoodIndicator(UserModel user) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.amber.shade700,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Utils.getMoodEmoji(user.moods.first.moodRating),
          const SizedBox(width: 4),
          Text(
            user.moods.first.mood,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Widget to build the input field
  Widget _buildInputField(bool isLoading) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              enabled: !isLoading, // Disable input during loading
              minLines: 1,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'What\'s on your mind?',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
              onSubmitted: (_) => _handleSendMessage(),
            ),
          ),
          GestureDetector(
            onTap: isLoading ? null : _handleSendMessage,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12),

              child: Icon(
                Icons.send,
                size: 24,
                color: isLoading ? Colors.grey.withOpacity(0.5) : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
