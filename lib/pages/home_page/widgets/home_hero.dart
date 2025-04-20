import 'package:cheerpup/commons/models/user_model.dart';
import 'package:cheerpup/commons/utils.dart';
import 'package:cheerpup/pages/home_page/riverpod/home_provider.dart';
import 'package:cheerpup/pages/layout/layout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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

    ref.read(homePageProvider.notifier).sendMessageToAI(message);

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homePageProvider);
    final user = homeState.currentUser;
    final isLoading = homeState.isLoading;
    final hasReachedLimit = homeState.hasReachedLimit;

    final now = DateTime.now();
    final dateFormat = DateFormat('EEE, dd MMM yyyy');
    final formattedDate = dateFormat.format(now);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade900, Colors.indigo.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ), // Darker brown color
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
          // Show either the input field or premium message based on limit
          hasReachedLimit
              ? _buildPremiumMessage()
              : _buildInputField(isLoading),
        ],
      ),
    );
  }

  Widget _buildPremiumMessage() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.amber.shade100,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.amber.shade300, width: 1.5),
      ),
      child: Row(
        children: [
          Icon(Icons.star, color: Colors.amber.shade800, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "Upgrade to premium services to chat more",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.amber.shade800,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // Navigate to premium upgrade page
              // context.goNamed('premium');
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.amber.shade800,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              "Upgrade",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

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
            user?.profileImage != null && user?.profileImage!.isNotEmpty == true
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
        // Mood indicator
        if (user != null && user.moods.isNotEmpty) _buildMoodIndicator(user),
      ],
    );
  }

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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
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
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Icon(
                Icons.send,
                size: 24,
                color:
                    isLoading
                        ? Colors.grey.withOpacity(0.5)
                        : const Color(0xFF5D4037),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
