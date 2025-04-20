import 'dart:convert';

import 'package:cheerpup/commons/constants/api_constants.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class ChatService {
  final String _baseUrl = ApiConstants.baseUrl;
  final String _authBox = 'auth_box';
  final String _authTokenKey = 'auth_token';
  final String _userIdKey = 'user_id';

  Future<Map<String, String>> _getHeaders() async {
    final box = await Hive.openBox(_authBox);
    final token = box.get(_authTokenKey);

    return {
      'Content-Type': 'application/json',
      'token': token != null ? 'Bearer $token' : '',
    };
  }

  Future<Map<String, dynamic>> chatWithOpenAI({
    required String feelingText,
  }) async {
    try {
      final box = await Hive.openBox(_authBox);
      final userId = box.get(_userIdKey);

      // Get proper headers with content-type
      final headers = await _getHeaders();

      // Create the request body as a Map and then encode to JSON
      final requestBody = {"userId": userId, "feelingText": feelingText};

      final response = await http.post(
        Uri.parse('$_baseUrl/openai/chat'),
        headers: headers,
        body: jsonEncode(requestBody), // Properly encode as JSON
      );

      print("chatWithOpenAI response status: ${response.statusCode}");
      print("chatWithOpenAI response body: ${response.body}");

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'data': responseData};
      } else {
        return {
          'success': false,
          'message':
              responseData['message'] ?? 'Failed to get response from AI',
        };
      }
    } catch (e) {
      print("Error in chatWithOpenAI: $e");
      return {
        'success': false,
        'message': 'An error occurred: ${e.toString()}',
      };
    }
  }

  // Fetch user chat history
  Future<Map<String, dynamic>> getUserChatHistory() async {
    try {
      final box = await Hive.openBox(_authBox);
      final userId = box.get(_userIdKey);

      if (userId == null) {
        return {'success': false, 'message': 'User ID not found'};
      }

      final headers = await _getHeaders();

      final response = await http.get(
        Uri.parse('$_baseUrl/user/chat/$userId'),
        headers: headers,
      );

      print("getUserChatHistory response status: ${response.statusCode}");
      print("getUserChatHistory response body: ${response.body}");

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'data': responseData};
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to get chat history',
        };
      }
    } catch (e) {
      print("Error in getUserChatHistory: $e");
      return {
        'success': false,
        'message': 'An error occurred: ${e.toString()}',
      };
    }
  }
}
