import 'package:cheerpup/commons/models/user_model.dart';

class ChatHistoryModel {
  final String id;
  final String userMessage;
  final String systemMessage;
  final List<String>? suggestedExercise;
  final List<String>? suggestedActivity;
  final List<MusicLinkModel> suggestedMusicLinks;
  final MusicLinkModel? suggestedMusicLink;

  ChatHistoryModel({
    required this.id,
    required this.userMessage,
    required this.systemMessage,
    this.suggestedExercise,
    this.suggestedActivity,
    required this.suggestedMusicLinks,
    this.suggestedMusicLink,
  });

  factory ChatHistoryModel.fromJson(Map<String, dynamic> json) {
    return ChatHistoryModel(
      id: json['_id'] ?? '',
      userMessage: json['userMessage'] ?? '',
      systemMessage: json['systemMessage'] ?? '',
      suggestedExercise:
          json['suggestedExercise'] != null
              ? List<String>.from(json['suggestedExercise'])
              : null,
      suggestedActivity:
          json['suggestedActivity'] != null
              ? List<String>.from(json['suggestedActivity'])
              : null,
      suggestedMusicLinks:
          (json['suggestedMusicLinks'] as List<dynamic>?)
              ?.map((link) => MusicLinkModel.fromJson(link))
              .toList() ??
          [],
      suggestedMusicLink:
          json['suggestedMusicLink'] != null
              ? MusicLinkModel.fromJson(json['suggestedMusicLink'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      '_id': id,
      'userMessage': userMessage,
      'systemMessage': systemMessage,
      'suggestedMusicLinks':
          suggestedMusicLinks.map((link) => link.toJson()).toList(),
    };

    if (suggestedExercise != null) {
      data['suggestedExercise'] = suggestedExercise;
    }
    if (suggestedActivity != null) {
      data['suggestedActivity'] = suggestedActivity;
    }
    if (suggestedMusicLink != null) {
      data['suggestedMusicLink'] = suggestedMusicLink!.toJson();
    }

    return data;
  }

  ChatHistoryModel copyWith({
    String? id,
    String? userMessage,
    String? systemMessage,
    List<String>? suggestedExercise,
    List<String>? suggestedActivity,
    List<MusicLinkModel>? suggestedMusicLinks,
    MusicLinkModel? suggestedMusicLink,
  }) {
    return ChatHistoryModel(
      id: id ?? this.id,
      userMessage: userMessage ?? this.userMessage,
      systemMessage: systemMessage ?? this.systemMessage,
      suggestedExercise: suggestedExercise ?? this.suggestedExercise,
      suggestedActivity: suggestedActivity ?? this.suggestedActivity,
      suggestedMusicLinks: suggestedMusicLinks ?? this.suggestedMusicLinks,
      suggestedMusicLink: suggestedMusicLink ?? this.suggestedMusicLink,
    );
  }
}
