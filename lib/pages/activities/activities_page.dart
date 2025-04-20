// lib/pages/activities_page/activities_page.dart

import 'package:cheerpup/commons/models/user_model.dart';
import 'package:cheerpup/pages/activities/models/activities_model.dart';
import 'package:cheerpup/pages/home_page/riverpod/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';




class ActivitiesPage extends ConsumerWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get exercises directly from our provider
    final exercises = ref.watch(homeProvider.select((value) => value.currentUser?.exercises));

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'My Activities',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black54),
            onPressed: () => _refreshUserData(context),
          ),
        ],
      ),
      body: exercises!.isEmpty
          ? _buildEmptyState(context)
          : RefreshIndicator(
              color: Colors.teal,
              onRefresh: () => _refreshUserData(context),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: exercises.length,
                itemBuilder: (context, index) {
                  final exercise = exercises[index];
                  return _buildExerciseCard(context, exercise);
                },
              ),
            ),
    );
  }

  Widget _buildExerciseCard(BuildContext context, ExerciseModel exercise) {
    // Determine if the exercise is completed today
    final hasCompletedToday = exercise.streak.isNotEmpty &&
        exercise.lastUpdated != null &&
        _isToday(exercise.lastUpdated!);

    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Status indicator
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: hasCompletedToday ? Colors.green.shade50 : Colors.grey.shade50,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: hasCompletedToday ? Colors.green : Colors.grey.shade300,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    hasCompletedToday ? Icons.check : Icons.fitness_center,
                    color: hasCompletedToday ? Colors.green : Colors.grey.shade400,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 20),
                
                // Exercise details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exercise.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Goal: ${exercise.durationInDays} days',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 10),
            
            // Streak information
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.local_fire_department,
                            color: Colors.deepOrange,
                            size: 20,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Streak: ${exercise.streak.length} days',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                // Status text
                hasCompletedToday
                    ? const Text(
                        'Completed Today',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : OutlinedButton.icon(
                        onPressed: () => _markAsCompleted(context, exercise),
                        icon: const Icon(Icons.check_circle_outline),
                        label: const Text('Mark as Done'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.teal,
                          side: const BorderSide(color: Colors.teal),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
              ],
            ),
            
            if (exercise.lastUpdated != null) ...[
              const SizedBox(height: 8),
              Text(
                'Last updated: ${_formatDate(exercise.lastUpdated!)}',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[500],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Format date for display
  String _formatDate(DateTime date) {
    final formatter = DateFormat('MMM d, yyyy');
    return formatter.format(date);
  }

  // Check if date is today
  bool _isToday(DateTime dateTime) {
    final now = DateTime.now();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }

  // Refresh user data function - simulating an API call
  Future<void> _refreshUserData(BuildContext context) async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 300));
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Activities refreshed'),
        backgroundColor: Colors.teal,
        duration: Duration(seconds: 1),
      ),
    );
  }

  // Mark exercise as completed
  void _markAsCompleted(BuildContext context, ExerciseModel exercise) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${exercise.name} completed! 🎉'),
        backgroundColor: Colors.teal,
      ),
    );
  }

  // Empty state widget
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.fitness_center,
              size: 70,
              color: Colors.teal.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'No Activities',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Your activities will appear here',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}