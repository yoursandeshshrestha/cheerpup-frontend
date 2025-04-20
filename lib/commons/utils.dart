import 'package:flutter/material.dart';

// This class contains utility methods that can be used throughout the app.
// It includes methods for getting the appropriate mood emoji based on a rating.
// The methods are static, so they can be called without creating an instance of the class.
// The class is designed to be reusable and modular, making it easy to maintain
// and extend in the future. The methods are also well-documented to provide
// clear explanations of their functionality and usage.
// Import necessary packages and constants.
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
