// lib/commons/services/exercise_service.dart

import 'dart:convert';
import 'package:cheerpup/commons/constants/api_constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class ExerciseService {
  final String _baseUrl = ApiConstants.baseUrl;
  final String _authBox = 'auth_box';
  final String _authTokenKey = 'auth_token';

  Future<Map<String, String>> _getHeaders() async {
    final box = await Hive.openBox(_authBox);
    final token = box.get(_authTokenKey);

    print("ExerciseService - Getting headers with token: $token");

    return {
      'Content-Type': 'application/json',
      'token': token != null ? 'Bearer $token' : '',
    };
  }

  // Add a new exercise for the user
  Future<Map<String, dynamic>> addExercise({
    required String userId,
    required String name,
    required int durationInDays,
  }) async {
    try {
      final headers = await _getHeaders();

      final requestBody = jsonEncode({
        'name': name,
        'durationInDays': durationInDays,
        'streak': [], // Initialize with empty streak array
      });

      print("Adding exercise for user $userId: $requestBody");

      final response = await http.post(
        Uri.parse('$_baseUrl/user/exercise/$userId'),
        headers: headers,
        body: requestBody,
      );

      print("Exercise add response status: ${response.statusCode}");
      print("Exercise add response body: ${response.body}");

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        return {'success': true, 'data': responseData};
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to add exercise',
        };
      }
    } catch (e) {
      print("Error in addExercise: $e");
      return {
        'success': false,
        'message': 'An error occurred: ${e.toString()}',
      };
    }
  }

  // Get exercises for a user
  Future<Map<String, dynamic>> getUserExercises(String userId) async {
    try {
      final headers = await _getHeaders();

      final response = await http.get(
        Uri.parse('$_baseUrl/user/exercise/$userId'),
        headers: headers,
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'data': responseData};
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to get exercises',
        };
      }
    } catch (e) {
      print("Error in getUserExercises: $e");
      return {
        'success': false,
        'message': 'An error occurred: ${e.toString()}',
      };
    }
  }

  // Delete exercise
  Future<Map<String, dynamic>> deleteExercise(
    String userId,
    String exerciseId,
  ) async {
    try {
      final headers = await _getHeaders();

      final response = await http.delete(
        Uri.parse('$_baseUrl/user/exercise/$userId/$exerciseId'),
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return {'success': true};
      } else {
        final responseData = jsonDecode(response.body);
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to delete exercise',
        };
      }
    } catch (e) {
      print("Error in deleteExercise: $e");
      return {
        'success': false,
        'message': 'An error occurred: ${e.toString()}',
      };
    }
  }
}
