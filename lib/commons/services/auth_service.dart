// lib/commons/services/auth_service.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cheerpup/commons/models/dto/login_user.dto.dart';
import 'package:cheerpup/commons/models/dto/create_user_dto.dart';
import 'package:cheerpup/commons/services/user_service.dart';

// Constants for Hive box and keys
const String AUTH_BOX = 'auth_box';
const String AUTH_TOKEN_KEY = 'auth_token';
const String USER_ID_KEY = 'user_id';

final authServiceProvider = Provider((ref) => AuthService());

class AuthService extends ChangeNotifier {
  final UserService _userService = UserService();
  String? _token;
  String? _userId;
  Map<String, dynamic>? _userData;
  bool _isInitialized = false;
  late Box _authBox;

  // Getters
  bool get isInitialized => _isInitialized;
  String? get token => _token;
  String? get userId => _userId;
  Map<String, dynamic>? get userData => _userData;

  // Initialize Hive and auth state
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Initialize Hive
      _authBox = await Hive.openBox(AUTH_BOX);

      // Get stored values
      _token = _authBox.get(AUTH_TOKEN_KEY);
      _userId = _authBox.get(USER_ID_KEY);

      print("Initialize - Retrieved token: $_token");
      print("Initialize - Retrieved userId: $_userId");

      if (_token != null && _userId != null) {
        // Fetch current user data
        try {
          final userResult = await _userService.getCurrentUser();
          print("Current user API response: $userResult");

          if (userResult['success']) {
            _userData = userResult['data']['user'];
            print("User data retrieved successfully: ${_userData?['name']}");
          } else {
            print("Failed to get user data: ${userResult['message']}");
            await logout();
          }
        } catch (e) {
          print('Error fetching user data: $e');
          await logout();
        }
      } else {
        print("No token or userId found in Hive");
      }

      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      print("Error during initialization: $e");
      _isInitialized =
          true; // Mark as initialized even on error to prevent infinite loops
      notifyListeners();
    }
  }

  Future<bool> isAuthenticated() async {
    if (!_isInitialized) {
      await initialize();
    }

    // Force re-read from storage - IMPORTANT
    _token = _authBox.get(AUTH_TOKEN_KEY);
    _userId = _authBox.get(USER_ID_KEY);

    print("isAuthenticated check - memory token: $_token");
    print(
      "isAuthenticated check - storage token: ${_authBox.get(AUTH_TOKEN_KEY)}",
    );

    return _token != null && _userId != null;
  }

  // Login user and store token and userId
  Future<Map<String, dynamic>> login(LoginUserDto loginDto) async {
    final result = await _userService.loginUser(loginDto);

    if (result['success']) {
      final responseData = result['data'];
      _token = responseData['token'];
      _userData = responseData['user'];
      _userId = _userData?['_id'];

      print("Login - Token to store: $_token");
      print("Login - UserId to store: $_userId");

      // Save token and userId to Hive
      try {
        await _authBox.put(AUTH_TOKEN_KEY, _token);
        if (_userId != null) {
          await _authBox.put(USER_ID_KEY, _userId);
        }

        // Verify storage
        final storedToken = _authBox.get(AUTH_TOKEN_KEY);
        final storedUserId = _authBox.get(USER_ID_KEY);
        print("Verification - Stored token: $storedToken");
        print("Verification - Stored userId: $storedUserId");

        // Important: Wait a small delay to ensure Hive writes are complete
        await Future.delayed(Duration(milliseconds: 100));

        notifyListeners();
      } catch (e) {
        print("Error storing auth data: $e");
      }
    }

    return result;
  }

  // Register user and store token
  Future<Map<String, dynamic>> signup(CreateUserDto createUserDto) async {
    final result = await _userService.createUser(createUserDto);

    if (result['success']) {
      final responseData = result['data'];
      _token = responseData['token'];
      _userData = responseData['user'];
      _userId = _userData?['_id'];

      print("Signup - Token to store: $_token");
      print("Signup - UserId to store: $_userId");

      // Save token and userId to Hive
      try {
        await _authBox.put(AUTH_TOKEN_KEY, _token);
        if (_userId != null) {
          await _authBox.put(USER_ID_KEY, _userId);
        }

        // Verify storage
        final storedToken = _authBox.get(AUTH_TOKEN_KEY);
        final storedUserId = _authBox.get(USER_ID_KEY);
        print("Verification - Stored token: $storedToken");
        print("Verification - Stored userId: $storedUserId");
      } catch (e) {
        print("Error storing auth data: $e");
      }

      notifyListeners();
    }

    return result;
  }

  // In AuthService class - revised logout method
  Future<void> logout() async {
    try {
      // Clear token from Hive first
      await _authBox.delete(AUTH_TOKEN_KEY);
      await _authBox.delete(USER_ID_KEY);
      print("Auth data cleared from Hive");

      // IMPORTANT: Clear memory variables AFTER clearing storage
      _token = null;
      _userId = null;
      _userData = null;

      // Double-check to verify values are cleared
      print("Memory variables cleared - token: $_token, userId: $_userId");

      // Force a delay to ensure all async operations complete
      await Future.delayed(Duration(milliseconds: 100));

      // Notify listeners that auth state has changed
      notifyListeners();
    } catch (e) {
      print("Error clearing auth data: $e");

      // Still clear memory variables even if storage clearing fails
      _token = null;
      _userId = null;
      _userData = null;

      notifyListeners();
    }
  }

  // Get token for API requests
  Future<String?> getToken() async {
    if (!_isInitialized) {
      await initialize();
    }
    return _token;
  }

  // Get userId for API requests
  Future<String?> getUserId() async {
    if (!_isInitialized) {
      await initialize();
    }
    return _userId;
  }
}
