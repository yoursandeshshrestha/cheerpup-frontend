// lib\commons\services\user_service.dart
// This file contains the UserService class, which handles user-related API calls
// and operations. It includes methods for creating, updating, deleting, and
// retrieving user profiles. The service uses the http package to make network
// requests and handles JSON encoding/decoding for the request and response data.
// It also includes error handling for network errors and server responses.
// Import necessary packages and constants.
import 'dart:convert';
import 'package:cheerpup/commons/constants/api_constants.dart';
import 'package:cheerpup/commons/models/dto/create_user_dto.dart';
import 'package:cheerpup/commons/models/dto/login_user.dto.dart';
import 'package:cheerpup/commons/models/dto/update_user_dto.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String _baseUrl = ApiConstants.baseUrl;

  Future<Map<String, String>> _getHeaders() async {
    final token = 'your-auth-token';

    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // Create user (signup)
  Future<Map<String, dynamic>> createUser(CreateUserDto dto) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(dto.toJson()),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return {'success': true, 'data': responseData};
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to create user',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred: ${e.toString()}',
      };
    }
  }

  // Create user (signup)
  Future<Map<String, dynamic>> loginUser(LoginUserDto dto) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(dto.toJson()),
      );

      final responseData = jsonDecode(response.body);

      // Return success based on HTTP status code from the server
      return {
        'success': response.statusCode == 200,
        'data': responseData,
        'message': responseData['message'],
        'statusCode': response.statusCode,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred: ${e.toString()}',
        'statusCode': 500, // Internal error
      };
    }
  }

  // Get current user profile
  Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$_baseUrl/me'),
        headers: headers,
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'data': responseData};
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to get user profile',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred: ${e.toString()}',
      };
    }
  }

  // Update user
  Future<Map<String, dynamic>> updateUser(
    String userId,
    UpdateUserDto dto,
  ) async {
    try {
      // Check if there are any fields to update
      if (dto.isEmpty) {
        return {'success': false, 'message': 'No fields to update'};
      }

      final headers = await _getHeaders();
      final response = await http.put(
        Uri.parse('$_baseUrl/$userId'),
        headers: headers,
        body: jsonEncode(dto.toJson()),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'data': responseData};
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to update user',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred: ${e.toString()}',
      };
    }
  }

  // Delete user
  Future<Map<String, dynamic>> deleteUser(String userId) async {
    try {
      final headers = await _getHeaders();
      final response = await http.delete(
        Uri.parse('$_baseUrl/$userId'),
        headers: headers,
      );

      if (response.statusCode == 204) {
        return {'success': true};
      } else {
        final responseData = jsonDecode(response.body);
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to delete user',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred: ${e.toString()}',
      };
    }
  }
}
