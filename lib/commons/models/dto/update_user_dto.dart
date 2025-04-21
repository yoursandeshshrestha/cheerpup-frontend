// lib/commons/models/dto/update_user_dto.dart

class UpdateUserDto {
  final String? name;
  final String? email;
  final String? phoneNumber;
  final int? age;
  final String? gender;
  final bool? isPhysicalHelpBefore;
  final bool? isPhysicalDistress;
  final List<String>? medicines;
  final int? seriousAlertCount;

  UpdateUserDto({
    this.name,
    this.email,
    this.phoneNumber,
    this.age,
    this.gender,
    this.isPhysicalHelpBefore,
    this.isPhysicalDistress,
    this.medicines,
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
    if (age != null) data['age'] = age;
    if (gender != null) data['gender'] = gender;
    if (isPhysicalHelpBefore != null) data['isPhysicalHelpBefore'] = isPhysicalHelpBefore;
    if (isPhysicalDistress != null) data['isPhysicalDistress'] = isPhysicalDistress;
    if (medicines != null) data['medicines'] = medicines;
    if (seriousAlertCount != null) data['seriousAlertCount'] = seriousAlertCount;

    return data;
  }

  /// Determines if DTO is empty (no fields set)
  bool get isEmpty => toJson().isEmpty;

  /// Creates a copy of this DTO with some fields replaced
  UpdateUserDto copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    int? age,
    String? gender,
    bool? isPhysicalHelpBefore,
    bool? isPhysicalDistress,
    List<String>? medicines,
    int? seriousAlertCount,
  }) {
    return UpdateUserDto(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      isPhysicalHelpBefore: isPhysicalHelpBefore ?? this.isPhysicalHelpBefore,
      isPhysicalDistress: isPhysicalDistress ?? this.isPhysicalDistress,
      medicines: medicines ?? this.medicines,
      seriousAlertCount: seriousAlertCount ?? this.seriousAlertCount,
    );
  }
}