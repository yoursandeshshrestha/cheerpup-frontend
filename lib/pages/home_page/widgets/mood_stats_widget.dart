import 'package:cheerpup/commons/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoodStatsWidget extends StatelessWidget {
  final List<MoodModel> moods;

  const MoodStatsWidget({super.key, required this.moods});

  @override
  Widget build(BuildContext context) {
    // Create a list for the last 7 days
    final now = DateTime.now();
    final last7Days = List.generate(7, (index) {
      return now.subtract(Duration(days: 6 - index));
    });

    // Process mood data for the last 7 days, calculating averages for each day
    final processedDays = _processMoodData(last7Days);

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
        border: Border.all(color: const Color(0xFFEADDD7), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.analytics_outlined,
                    color: Colors.purple.shade700,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Your Mood Trends",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple.shade700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildColorDotTracker(context, last7Days, processedDays),
            const SizedBox(height: 12),
            _buildMoodInsights(moods),
          ],
        ),
      ),
    );
  }

  // Process mood data to calculate daily averages
  Map<DateTime, double> _processMoodData(List<DateTime> days) {
    final Map<DateTime, double> processedDays = {};

    for (final day in days) {
      final dayMoods = _findAllMoodsForDay(day);
      if (dayMoods.isEmpty) {
        // Skip adding to the map - we'll handle missing days in the UI
        continue;
      }

      // Calculate average mood rating for this day
      final totalRating = dayMoods.fold(
        0,
        (sum, mood) => sum + mood.moodRating,
      );
      final avgRating = totalRating / dayMoods.length;

      processedDays[day] = avgRating;
    }

    return processedDays;
  }

  // Find all moods for a specific day
  List<MoodModel> _findAllMoodsForDay(DateTime day) {
    final List<MoodModel> dayMoods = [];

    for (final mood in moods) {
      try {
        final createdAt = getCreatedAtFromMood(mood);
        if (createdAt == null) continue;

        final moodDate = DateTime.parse(createdAt);
        if (moodDate.year == day.year &&
            moodDate.month == day.month &&
            moodDate.day == day.day) {
          dayMoods.add(mood);
        }
      } catch (e) {
        // Continue checking other moods if this one fails
        continue;
      }
    }

    return dayMoods;
  }

  // Alternative approach using color dots with average mood ratings
  Widget _buildColorDotTracker(
    BuildContext context,
    List<DateTime> allDays,
    Map<DateTime, double> moodData,
  ) {
    final dateFormat = DateFormat('dd/MM');

    return Column(
      children: [
        // Color dots grid
        SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                allDays.map((day) {
                  // Get mood data if it exists for this day
                  final hasMoodData = moodData.containsKey(day);
                  final avgMoodRating = hasMoodData ? moodData[day]! : 0.0;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      hasMoodData
                          ? _buildMoodDot(avgMoodRating, 35)
                          : _buildEmptyMoodDot(35),
                      const SizedBox(height: 8),
                      Text(
                        dateFormat.format(day),
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  );
                }).toList(),
          ),
        ),
        const SizedBox(height: 16),
        // Mood legend
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegendItem("Rough", _getMoodColor(1)),
            const SizedBox(width: 12),
            _buildLegendItem("Neutral", _getMoodColor(3)),
            const SizedBox(width: 12),
            _buildLegendItem("Great", _getMoodColor(5)),
          ],
        ),
      ],
    );
  }

  // Build a mood dot for days with data
  Widget _buildMoodDot(double moodRating, double size) {
    // Round the mood rating for display purposes
    final displayRating = moodRating.toStringAsFixed(1);

    // Colors based on mood rating
    final color = _getMoodColorForAverage(moodRating);

    // Build a circular dot with the mood color
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Center(
        child: Text(
          displayRating,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Build an empty/dash mood dot for days without data
  Widget _buildEmptyMoodDot(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Center(
        child: Text(
          "-",
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
        ),
      ],
    );
  }

  // Get color based on average mood rating (can handle decimal values)
  Color _getMoodColorForAverage(double moodRating) {
    if (moodRating <= 1.5) {
      return Colors.red.shade500;
    } else if (moodRating <= 2.5) {
      return Colors.orange.shade500;
    } else if (moodRating <= 3.5) {
      return Colors.amber.shade500;
    } else if (moodRating <= 4.5) {
      return Colors.lightGreen.shade500;
    } else {
      return Colors.green.shade500;
    }
  }

  Color _getMoodColor(int moodRating) {
    switch (moodRating) {
      case 1:
        return Colors.red.shade500;
      case 2:
        return Colors.orange.shade500;
      case 3:
        return Colors.amber.shade500;
      case 4:
        return Colors.lightGreen.shade500;
      case 5:
        return Colors.green.shade500;
      default:
        return Colors.grey.shade200; // Empty/no data
    }
  }

  Widget _buildMoodInsights(List<MoodModel> moods) {
    if (moods.isEmpty) {
      return _buildEmptyState();
    }

    // Calculate average mood if we have data
    final totalRating = moods.fold(0, (sum, mood) => sum + mood.moodRating);
    final avgRating = moods.isNotEmpty ? totalRating / moods.length : 0;

    String insightText;
    IconData insightIcon;
    Color insightColor;

    if (avgRating >= 4) {
      insightText =
          "You've been feeling great lately. Keep up the positive energy!";
      insightIcon = Icons.sentiment_very_satisfied;
      insightColor = Colors.green.shade700;
    } else if (avgRating >= 3) {
      insightText =
          "Your mood has been steady. Try some recommended activities to boost your spirits even more.";
      insightIcon = Icons.sentiment_satisfied;
      insightColor = Colors.amber.shade700;
    } else if (avgRating > 0) {
      insightText =
          "You've been feeling down lately. Consider trying some of the suggested exercises to help improve your mood.";
      insightIcon = Icons.sentiment_dissatisfied;
      insightColor = Colors.orange.shade700;
    } else {
      insightText =
          "Start tracking your mood by chatting with our AI assistant.";
      insightIcon = Icons.chat_bubble_outline;
      insightColor = Colors.purple.shade700;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(insightIcon, color: insightColor, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              insightText,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade800,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            color: Colors.purple.shade700,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "Start tracking your mood by chatting with our AI assistant. Your mood data will appear here.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade800,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Helper to get createdAt from MoodModel based on the observed structure
String? getCreatedAtFromMood(MoodModel mood) {
  try {
    // Cast to dynamic to access the property that exists in runtime but not in the class definition
    final dynamic dynamicMood = mood;
    return dynamicMood.createdAt as String?;
  } catch (e) {
    print('Error getting createdAt: $e');
    return null;
  }
}
