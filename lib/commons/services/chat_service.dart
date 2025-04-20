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

    print("UserService - Getting headers with token: $token");

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

      final headers = await _getHeaders();
      print("chatWithOpenAI headers: $headers");

      final requestBody = {"userId": userId, "feelingText": feelingText};

      final response = await http.post(
        Uri.parse('$_baseUrl/openai/chat'),
        body: jsonEncode(requestBody),
      );

      print("chatWithOpenAI response status: ${response.statusCode}");
      print("chatWithOpenAI response body: ${response.body}");

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
      print("Error in chatWithOpenAI: $e");
      return {
        'success': false,
        'message': 'An error occurred: ${e.toString()}',
      };
    }
  }
}
