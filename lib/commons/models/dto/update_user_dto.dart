// lib/models/dto/update_user_dto.dart

class UpdateUserDto {
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? password;
  final String? profileImage;

  // Additional fields that could be updated
  final List<String>? medicines;
  final List<String>? exercises;
  final int? seriousAlertCount;

  UpdateUserDto({
    this.name,
    this.email,
    this.phoneNumber,
    this.password,
    this.profileImage,
    this.medicines,
    this.exercises,
    this.seriousAlertCount,
  });

  /// Converts DTO to JSON map for API request
  /// Only includes non-null fields in the request
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    // Only add fields that are not null
    if (name != null) data['name'] = name;
    if (email != null) data['email'] = email;
    if (phoneNumber != null) data['phoneNumber'] = phoneNumber;
    if (password != null) data['password'] = password;
    if (profileImage != null) data['profileImage'] = profileImage;
    if (medicines != null) data['medicines'] = medicines;
    if (exercises != null) data['exercises'] = exercises;
    if (seriousAlertCount != null)
      data['seriousAlertCount'] = seriousAlertCount;

    return data;
  }

  /// Determines if DTO is empty (no fields set)
  bool get isEmpty => toJson().isEmpty;

  /// Creates a copy of this DTO with some fields replaced
  UpdateUserDto copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? password,
    String? profileImage,
    List<String>? medicines,
    List<String>? exercises,
    int? seriousAlertCount,
  }) {
    return UpdateUserDto(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      profileImage: profileImage ?? this.profileImage,
      medicines: medicines ?? this.medicines,
      exercises: exercises ?? this.exercises,
      seriousAlertCount: seriousAlertCount ?? this.seriousAlertCount,
    );
  }
}
