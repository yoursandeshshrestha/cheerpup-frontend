import 'package:cheerpup/pages/home_page/riverpod/home_provider.dart';
import 'package:cheerpup/pages/home_page/riverpod/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This widget is responsible for displaying the home content of the app.
// It includes sections for AI responses, suggested activities, and suggested exercises.
class HomeContent extends ConsumerWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    // Filter to only show AI messages (not user messages)
    final messages =
        homeState.messages.where((msg) => !msg.isUserMessage).toList();
    final suggestedActivities = homeState.suggestedActivities;
    final suggestedExercises = homeState.suggestedExercises;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          // Messages section (AI responses only)
          if (messages.isNotEmpty) ...[
            _buildMessagesSection(context, messages),
            const SizedBox(height: 24),
          ],

          // Suggested activities section (short-term activities)
          if (suggestedActivities.isNotEmpty) ...[
            _buildSectionTitle('Suggested Activities'),
            const SizedBox(height: 8),
            ...suggestedActivities.map(
              (activity) => _buildActivityCard(context, activity, ref),
            ),
            const SizedBox(height: 24),
          ],

          // Suggested exercises section (long-term habits)
          if (suggestedExercises.isNotEmpty) ...[
            _buildSectionTitle('Suggested Exercises'),
            const SizedBox(height: 8),
            ...suggestedExercises.map(
              (exercise) => _buildExerciseCard(context, exercise, ref),
            ),
            const SizedBox(height: 40),
          ],
        ],
      ),
    );
  }

// Build the section title
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF694E3E),
      ),
    );
  }

  // Build the messages section (AI responses)

  Widget _buildMessagesSection(BuildContext context, List<Message> messages) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Responses'),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return _buildMessageBubble(context, messages[index]);
          },
        ),
      ],
    );
  }

// Build the message bubble for AI responses
  Widget _buildMessageBubble(BuildContext context, Message message) {
    // Full width container for AI responses
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            message.isPending
                ? const Center(
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF694E3E),
                      ),
                    ),
                  ),
                )
                : Text(
                  message.text,
                  style: const TextStyle(
                    color: Color(0xFF694E3E),
                    fontSize: 14,
                  ),
                ),
      ),
    );
  }

  // For short-term activities with Done/Cancel buttons
  Widget _buildActivityCard(
    BuildContext context,
    String activity,
    WidgetRef ref,
  ) {
    // Parse activity string into title and description
    final parts = activity.split(': ');
    final title = parts[0];
    final description = parts.length > 1 ? parts[1] : '';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF694E3E),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Done button
                _buildActionButton(
                  context,
                  'Done',
                  Icons.check_circle,
                  Colors.green,
                  () {
                    // Mark as done and remove from list
                    ref
                        .read(homeProvider.notifier)
                        .toggleActivity(activity, false);
                    // Could show a success message or add to completed activities
                  },
                ),
                const SizedBox(width: 8),
                // Cancel button
                _buildActionButton(
                  context,
                  'Cancel',
                  Icons.close,
                  Colors.grey,
                  () {
                    // Remove from suggestions
                    ref
                        .read(homeProvider.notifier)
                        .toggleActivity(activity, false);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // For long-term exercises with Add Habit/Ignore buttons
  Widget _buildExerciseCard(
    BuildContext context,
    String exercise,
    WidgetRef ref,
  ) {
    // Parse exercise string into title and description
    final parts = exercise.split(': ');
    final title = parts[0];
    final description = parts.length > 1 ? parts[1] : '';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF694E3E),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Add Habit button
                _buildActionButton(
                  context,
                  'Add Habit',
                  Icons.add_circle_outline,
                  Colors.blue,
                  () {
                    // Add to habits
                    ref
                        .read(homeProvider.notifier)
                        .toggleActivity(exercise, true);
                    // Could navigate to habits screen or show confirmation
                  },
                ),
                const SizedBox(width: 8),
                // Ignore button
                _buildActionButton(
                  context,
                  'Ignore',
                  Icons.not_interested,
                  Colors.grey,
                  () {
                    // Remove from suggestions
                    ref
                        .read(homeProvider.notifier)
                        .toggleActivity(exercise, true);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

// Build the action button for exercises and activities
  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
