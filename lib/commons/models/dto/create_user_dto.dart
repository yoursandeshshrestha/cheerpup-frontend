// lib/models/dto/create_user_dto.dart

class CreateUserDto {
  final String name;
  final String email;
  final String phoneNumber;
  final String password;

  CreateUserDto({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  /// Converts DTO to JSON map for API request
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
    };

    return data;
  }

  CreateUserDto copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? password,
  }) {
    return CreateUserDto(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
    );
  }
}
