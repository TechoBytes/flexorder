import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String _userType = 'retailer'; // 'retailer' or 'wholesaler'
  String _userName = 'John Doe';
  String _userEmail = 'john.doe@example.com';
  bool _isLoading = false;

  bool get isAuthenticated => _isAuthenticated;
  String get userType => _userType;
  String get userName => _userName;
  String get userEmail => _userEmail;
  bool get isLoading => _isLoading;

  // Mock login functionality
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      if (email.isNotEmpty && password.isNotEmpty) {
        _isAuthenticated = true;
        _userEmail = email;
        
        // Set default name based on email
        _userName = email.split('@').first;
        
        // For demo, set user type based on email domain
        if (email.contains('wholesaler')) {
          _userType = 'wholesaler';
        } else {
          _userType = 'retailer';
        }
        
        notifyListeners();
        return true;
      }
      
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Mock register functionality
  Future<bool> register(String name, String email, String password, String userType) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        _isAuthenticated = true;
        _userName = name;
        _userEmail = email;
        _userType = userType;
        
        notifyListeners();
        return true;
      }
      
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Mock OTP verification
  Future<bool> verifyOTP(String email, String otp) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // For demo purposes, any 6-digit OTP is valid
      if (otp.length == 6 && RegExp(r'^\d{6}$').hasMatch(otp)) {
        return true;
      }
      
      throw Exception('Invalid OTP');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Mock send OTP
  Future<void> sendOTP(String email) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // In a real app, this would trigger an email/SMS with the OTP
      if (!email.contains('@')) {
        throw Exception('Invalid email address');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Sign out
  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      _isAuthenticated = false;
      _userName = '';
      _userEmail = '';
      _userType = 'retailer';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update user info
  void updateUserInfo({String? name, String? email, String? userType}) {
    if (name != null) _userName = name;
    if (email != null) _userEmail = email;
    if (userType != null) _userType = userType;
    
    notifyListeners();
  }
} 