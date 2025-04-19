import 'package:flutter/material.dart';

class Utils {
  /// Helper method to get the appropriate mood emoji based on rating
  static Icon getMoodEmoji(int moodRating) {
    switch (moodRating) {
      case 1:
        return const Icon(
          Icons.sentiment_very_dissatisfied,
          color: Colors.white,
          size: 14,
        );
      case 2:
        return const Icon(
          Icons.sentiment_dissatisfied,
          color: Colors.white,
          size: 14,
        );
      case 3:
        return const Icon(
          Icons.sentiment_neutral,
          color: Colors.white,
          size: 14,
        );
      case 4:
        return const Icon(
          Icons.sentiment_satisfied,
          color: Colors.white,
          size: 14,
        );
      case 5:
        return const Icon(
          Icons.sentiment_very_satisfied,
          color: Colors.white,
          size: 14,
        );
      default:
        return const Icon(
          Icons.sentiment_neutral,
          color: Colors.white,
          size: 14,
        );
    }
  }
}
