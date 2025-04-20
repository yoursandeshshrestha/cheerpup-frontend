// This file contains the Exercise model, which represents an exercise
// and its associated data. It includes properties for the exercise's ID,
// name, duration, streak, last updated date, creation date, and update date.
class Exercise {
  final String id;
  final String name;
  final int durationInDays;
  final List<int> streak;
  final DateTime? lastUpdated;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Exercise({
    required this.id,
    required this.name,
    required this.durationInDays,
    required this.streak,
    this.lastUpdated,
    this.createdAt,
    this.updatedAt,
  });

  // Converts the Exercise object to a JSON map.
  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['_id'] as String,
      name: json['name'] as String,
      durationInDays: json['durationInDays'] as int,
      streak: (json['streak'] as List<dynamic>).map((e) => e as int).toList(),
      lastUpdated:
          json['lastUpdated'] != null
              ? DateTime.parse(json['lastUpdated'] as String)
              : null,
      createdAt:
          json['createdAt'] != null
              ? DateTime.parse(json['createdAt'] as String)
              : null,
      updatedAt:
          json['updatedAt'] != null
              ? DateTime.parse(json['updatedAt'] as String)
              : null,
    );
  }
}
