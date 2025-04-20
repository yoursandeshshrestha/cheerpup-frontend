// lib/pages/activities/widgets/exercise_card.dart

import 'package:cheerpup/pages/activities/models/activities_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final VoidCallback onUpdate;
  final VoidCallback onDelete;

  const ExerciseCard({
    Key? key,
    required this.exercise,
    required this.onUpdate,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if the exercise was completed today
    final bool isCompletedToday = _isCompletedToday();

    // Format the last updated date if available
    String lastUpdatedText = 'Not started yet';
    if (exercise.lastUpdated != null) {
      lastUpdatedText = 'Last done: ${_formatDate(exercise.lastUpdated!)}';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onUpdate,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Status indicator with animation
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color:
                          isCompletedToday
                              ? Colors.green[100]
                              : Colors.grey[100],
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:
                            isCompletedToday
                                ? Colors.green
                                : Colors.grey.shade300,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        isCompletedToday ? Icons.check : Icons.fitness_center,
                        color:
                            isCompletedToday
                                ? Colors.green
                                : Colors.grey.shade400,
                        size: 30,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Exercise info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exercise.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Goal: ${exercise.durationInDays} days',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.local_fire_department,
                              color: Colors.deepOrange,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Streak: ${exercise.streak.length} days',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.deepOrange,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          lastUpdatedText,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Action buttons
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Mark as done button
                      ElevatedButton(
                        onPressed: isCompletedToday ? null : onUpdate,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isCompletedToday ? Colors.grey[200] : Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          minimumSize: const Size(100, 36),
                        ),
                        child: Text(
                          isCompletedToday ? 'Completed' : 'Mark Done',
                          style: TextStyle(
                            color:
                                isCompletedToday
                                    ? Colors.grey[600]
                                    : Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Delete button
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                          size: 22,
                        ),
                        onPressed: onDelete,
                        tooltip: 'Delete',
                        constraints: const BoxConstraints(
                          minWidth: 36,
                          minHeight: 36,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isCompletedToday() {
    if (exercise.lastUpdated == null || exercise.streak.isEmpty) {
      return false;
    }

    final now = DateTime.now();
    final lastUpdated = exercise.lastUpdated!;

    return lastUpdated.year == now.year &&
        lastUpdated.month == now.month &&
        lastUpdated.day == now.day;
  }

  String _formatDate(DateTime dateTime) {
    final formatter = DateFormat('MMM d, yyyy');
    return formatter.format(dateTime);
  }
}
