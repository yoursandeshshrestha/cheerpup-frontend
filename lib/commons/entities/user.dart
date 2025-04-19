import 'package:flutter/material.dart';

class User {
  final bool isSubscribed;
  final String mood;
  final Icon moodEmoji;
  final double progressPercentage; // For the progress indicator (80%)
  final String? profileImageUrl; // For profile image if available

  // Additional fields for profile page
  final String? fullName;
  final String? email;
  final String? password;
  final String? accountType;
  final double? weight;
  final String? gender;
  final String? location;

  User({
    required this.isSubscribed,
    required this.mood,
    required this.moodEmoji,
    this.progressPercentage = 0.0,
    this.profileImageUrl,
    this.fullName,
    this.email,
    this.password,
    this.accountType = 'Patient',
    this.weight = 65.0,
    this.gender = 'Trans Female',
    this.location = 'Tokyo, Japan',
  });

  // Factory constructor to create a default user
  factory User.defaultUser() {
    return User(
      isSubscribed: false,
      mood: 'Neutral',
      moodEmoji: const Icon(
        Icons.sentiment_neutral,
        color: Colors.white,
        size: 14,
      ),
      progressPercentage: 0.0,
    );
  }

  // Method to create a copy of the user with updated values
  User copyWith({
    String? username,
    bool? isSubscribed,
    String? mood,
    Icon? moodEmoji,
    double? progressPercentage,
    String? profileImageUrl,
    String? fullName,
    String? email,
    String? password,
    String? accountType,
    double? weight,
    String? gender,
    String? location,
  }) {
    return User(
      isSubscribed: isSubscribed ?? this.isSubscribed,
      mood: mood ?? this.mood,
      moodEmoji: moodEmoji ?? this.moodEmoji,
      progressPercentage: progressPercentage ?? this.progressPercentage,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      accountType: accountType ?? this.accountType,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
      location: location ?? this.location,
    );
  }
}
