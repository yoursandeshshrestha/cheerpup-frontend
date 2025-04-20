// lib/commons/services/user_service.dart

import 'dart:convert';
import 'package:cheerpup/commons/constants/api_constants.dart';
import 'package:cheerpup/commons/models/dto/create_user_dto.dart';
import 'package:cheerpup/commons/models/dto/login_user.dto.dart';
import 'package:cheerpup/commons/models/dto/update_user_dto.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';

class UserService {
  final String _baseUrl = ApiConstants.baseUrl;
  final String _authBox = 'auth_box';
  final String _authTokenKey = 'auth_token';
  final String _userIdKey = 'user_id';

  Future<Map<String, String>> _getHeaders() async {
    final box = await Hive.openBox(_authBox);
    final token = box.get(_authTokenKey);

    print("UserService - Getting headers with token: $token");

    return {
      'Content-Type': 'application/json',
      'token': token != null ? 'Bearer $token' : '',
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
      print("Error in createUser: $e");
      return {
        'success': false,
        'message': 'An error occurred: ${e.toString()}',
      };
    }
  }

  // Login user
  Future<Map<String, dynamic>> loginUser(LoginUserDto dto) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(dto.toJson()),
      );

      final responseData = jsonDecode(response.body);
      print("Login response: ${response.statusCode}, data: $responseData");

      // Return success based on HTTP status code from the server
      return {
        'success': response.statusCode == 200,
        'data': responseData,
        'message': responseData['message'],
        'statusCode': response.statusCode,
      };
    } catch (e) {
      print("Error in loginUser: $e");
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
      print("getCurrentUser headers: $headers");

      final box = await Hive.openBox(_authBox);
      final userId = box.get(_userIdKey);

      final response = await http.get(
        Uri.parse('$_baseUrl/user/$userId'),
        headers: headers,
      );

      print("getCurrentUser response status: ${response.statusCode}");
      print("getCurrentUser response body: ${response.body}");

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
      print("Error in getCurrentUser: $e");
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
        Uri.parse('$_baseUrl/user/$userId'),
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
      print("Error in updateUser: $e");
      return {
        'success': false,
        'message': 'An error occurred: ${e.toString()}',
      };
    }
  }

  // Add this method to your UserService class

  // Upload profile image
  Future<Map<String, dynamic>> uploadProfileImage(
    String userId,
    String imagePath,
  ) async {
    try {
      final headers = await _getHeaders();

      // Create a multipart request
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('$_baseUrl/user/$userId'),
      );

      // Add the auth headers
      headers.forEach((key, value) {
        request.headers[key] = value;
      });

      // Add the file
      request.files.add(await http.MultipartFile.fromPath('file', imagePath));

      // Send the request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'data': responseData};
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to upload image',
        };
      }
    } catch (e) {
      print("Error in uploadProfileImage: $e");
      return {
        'success': false,
        'message': 'An error occurred: ${e.toString()}',
      };
    }
  }
}
