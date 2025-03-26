import 'package:flutter/material.dart';

enum UserType {
  wholesaler,
  retailer,
  unknown,
}

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  String _userId = '';
  String _userEmail = '';
  String _userName = '';
  UserType _userType = UserType.unknown;
  bool _isLoading = false;
  final bool _mockMode;

  // Constructor to set up mock mode for development
  AuthProvider({bool mockMode = false}) : _mockMode = mockMode {
    if (_mockMode) {
      // For testing purposes
      _isAuthenticated = false;
      _userType = UserType.retailer;
    }
  }

  // Getters
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  String get userId => _userId;
  String get userEmail => _userEmail;
  String get userName => _userName;
  UserType get userType => _userType;
  bool get isMockMode => _mockMode;

  // Methods for authentication
  Future<void> signIn(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      if (_mockMode) {
        await Future.delayed(const Duration(seconds: 1));
        _isAuthenticated = true;
        _userId = 'mock-user-id';
        _userEmail = email;
        _userName = email.split('@')[0];
      } else {
        // Here would be the actual API call to authenticate
        await Future.delayed(const Duration(seconds: 1));
        
        _isAuthenticated = true;
        _userId = 'user-123';
        _userEmail = email;
        _userName = 'John Doe';
      }
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUp(String email, String password, String name, UserType type) async {
    try {
      _isLoading = true;
      notifyListeners();

      if (_mockMode) {
        await Future.delayed(const Duration(seconds: 1));
        _isAuthenticated = true;
        _userId = 'mock-user-id';
        _userEmail = email;
        _userName = name;
        _userType = type;
      } else {
        // Here would be the actual API call to register
        await Future.delayed(const Duration(seconds: 1));
        
        _isAuthenticated = true;
        _userId = 'user-123';
        _userEmail = email;
        _userName = name;
        _userType = type;
      }
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    try {
      _isLoading = true;
      notifyListeners();

      if (_mockMode) {
        await Future.delayed(const Duration(milliseconds: 500));
      } else {
        // Here would be the actual API call to sign out
        await Future.delayed(const Duration(milliseconds: 500));
      }
      
      _isAuthenticated = false;
      _userId = '';
      _userEmail = '';
      _userName = '';
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> verifyOTP(String email, String otp) async {
    try {
      _isLoading = true;
      notifyListeners();

      if (_mockMode) {
        await Future.delayed(const Duration(seconds: 1));
        // Any OTP is valid in mock mode
        return;
      }

      // Here would be the API call to verify OTP
      await Future.delayed(const Duration(seconds: 1));
      
      // Check if OTP is valid (mock implementation)
      if (otp != '123456') {
        throw Exception('Invalid OTP');
      }
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sendOTP(String email) async {
    try {
      _isLoading = true;
      notifyListeners();

      if (_mockMode) {
        await Future.delayed(const Duration(seconds: 1));
        return;
      }

      // Here would be the API call to send OTP
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      _isLoading = true;
      notifyListeners();

      if (_mockMode) {
        await Future.delayed(const Duration(seconds: 1));
        return;
      }

      // Here would be the API call to reset password
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Method to update user type
  void setUserType(UserType type) {
    _userType = type;
    notifyListeners();
  }

  // Toggle between retailer and wholesaler (for demo purposes)
  void toggleUserType() {
    if (_userType == UserType.retailer) {
      _userType = UserType.wholesaler;
    } else {
      _userType = UserType.retailer;
    }
    notifyListeners();
  }
} 