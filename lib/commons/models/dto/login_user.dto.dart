// lib/commons/models/dto/login_user_dto.dart

class LoginUserDto {
  final String identifier; // Can be either email or phone number
  final String password;

  LoginUserDto({required this.identifier, required this.password});

  /// Converts DTO to JSON map for API request
  Map<String, dynamic> toJson() {
    return {'identifier': identifier, 'password': password};
  }
}
