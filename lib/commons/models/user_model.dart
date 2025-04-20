// lib/models/user_model.dart

import 'package:cheerpup/pages/chat_history/model/chat_message.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String? profileImage;
  final List<String> medicines;
  final List<ExerciseModel> exercises;
  final List<ChatHistoryModel> apiChatHistory;
  final List<MoodModel> moods;
  final int seriousAlertCount;
  final bool isAdmin;
  final int weight;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.profileImage,
    required this.medicines,
    required this.exercises,
    required this.apiChatHistory,
    required this.moods,
    required this.seriousAlertCount,
    required this.isAdmin,

    required this.weight,
  });

  /// Factory constructor to create a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      profileImage: json['profileImage'],
      medicines: List<String>.from(json['medicines'] ?? []),
      exercises:
          (json['exercises'] as List<dynamic>?)
              ?.map((exercise) => ExerciseModel.fromJson(exercise))
              .toList() ??
          [],
      apiChatHistory:
          (json['apiChatHistory'] as List<dynamic>?)
              ?.map((chat) => ChatHistoryModel.fromJson(chat))
              .toList() ??
          [],
      moods:
          (json['moods'] as List<dynamic>?)
              ?.map((mood) => MoodModel.fromJson(mood))
              .toList() ??
          [],
      seriousAlertCount: json['seriousAlertCount'] ?? 0,
      isAdmin: json['isAdmin'] ?? false,
      weight: json["weight"] ?? 0,
    );
  }

  /// Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'medicines': medicines,
      'exercises': exercises.map((e) => e.toJson()).toList(),
      'apiChatHistory': apiChatHistory.map((c) => c.toJson()).toList(),
      'moods': moods.map((m) => m.toJson()).toList(),
      'seriousAlertCount': seriousAlertCount,
      'isAdmin': isAdmin,
      'weight': weight,
    };
  }

  /// Create a copy of UserModel with some fields replaced
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? profileImage,
    List<String>? medicines,
    List<ExerciseModel>? exercises,
    List<ChatHistoryModel>? apiChatHistory,
    List<MoodModel>? moods,
    int? seriousAlertCount,
    bool? isAdmin,
    int? weight,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
      medicines: medicines ?? this.medicines,
      exercises: exercises ?? this.exercises,
      apiChatHistory: apiChatHistory ?? this.apiChatHistory,
      moods: moods ?? this.moods,
      seriousAlertCount: seriousAlertCount ?? this.seriousAlertCount,
      isAdmin: isAdmin ?? this.isAdmin,
      weight: weight ?? this.weight,
    );
  }
}

class ExerciseModel {
  final String id;
  final String name;
  final int durationInDays;
  final List<int> streak;
  final DateTime? lastUpdated;

  ExerciseModel({
    required this.id,
    required this.name,
    required this.durationInDays,
    required this.streak,
    this.lastUpdated,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      durationInDays: json['durationInDays'] ?? 0,
      streak: List<int>.from(json['streak'] ?? []),
      lastUpdated:
          json['lastUpdated'] != null
              ? DateTime.parse(json['lastUpdated'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'durationInDays': durationInDays,
      'streak': streak,
      'lastUpdated': lastUpdated?.toIso8601String(),
    };
  }

  ExerciseModel copyWith({
    String? id,
    String? name,
    int? durationInDays,
    List<int>? streak,
    DateTime? lastUpdated,
  }) {
    return ExerciseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      durationInDays: durationInDays ?? this.durationInDays,
      streak: streak ?? this.streak,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

class MoodModel {
  final String id;
  final int moodRating;
  final String mood;
  final String createdAt;
  final String updatedAt;

  MoodModel({
    required this.id,
    required this.moodRating,
    required this.mood,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MoodModel.fromJson(Map<String, dynamic> json) {
    return MoodModel(
      id: json['_id'] ?? '',
      moodRating: json['moodRating'] ?? 3,
      mood: json['mood'] ?? 'Neutral',
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'moodRating': moodRating,
      'mood': mood,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  MoodModel copyWith({
    String? id,
    int? moodRating,
    String? mood,
    String? createdAt,
    String? updatedAt,
  }) {
    return MoodModel(
      id: id ?? this.id,
      moodRating: moodRating ?? this.moodRating,
      mood: mood ?? this.mood,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class MusicLinkModel {
  final String? id;
  final String? title;
  final String? link;

  MusicLinkModel({this.id, this.title, this.link});

  factory MusicLinkModel.fromJson(Map<String, dynamic> json) {
    return MusicLinkModel(
      id: json['_id'],
      title: json['title'],
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (id != null) data['_id'] = id;
    if (title != null) data['title'] = title;
    if (link != null) data['link'] = link;

    return data;
  }

  MusicLinkModel copyWith({String? id, String? title, String? link}) {
    return MusicLinkModel(
      id: id ?? this.id,
      title: title ?? this.title,
      link: link ?? this.link,
    );
  }
}

// Add these extension methods to UserModel

// Extension to check if user has recent chat history
extension UserChatExtensions on UserModel {
  // Check if user has any chats within the last 24 hours
  bool hasRecentChats() {
    if (apiChatHistory.isEmpty) return false;

    final now = DateTime.now();

    return apiChatHistory.any((chat) {
      if (chat.createdAt == null) return false;

      try {
        final chatTime = DateTime.parse(chat.createdAt!);
        final difference = now.difference(chatTime).inHours;
        return difference < 24;
      } catch (e) {
        print('Error parsing chat timestamp: $e');
        return false;
      }
    });
  }

  // Get number of chats within the last 24 hours
  int getRecentChatCount() {
    if (apiChatHistory.isEmpty) return 0;

    final now = DateTime.now();
    int count = 0;

    for (var chat in apiChatHistory) {
      if (chat.createdAt == null) continue;

      try {
        final chatTime = DateTime.parse(chat.createdAt!);
        final difference = now.difference(chatTime).inHours;
        if (difference < 24) count++;
      } catch (e) {
        print('Error parsing chat timestamp: $e');
      }
    }

    return count;
  }
}
