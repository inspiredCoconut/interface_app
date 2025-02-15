import 'package:flutter/material.dart';
import '../data/models/user_model.dart';
import '../data/repositories/auth_repository.dart';

// AuthService class to handle user authentication
class AuthService extends ChangeNotifier {
  User? _currentUser;
  final AuthRepository authRepository = AuthRepository();

  User? get currentUser => _currentUser;

  // Register a new user
  Future<bool> register(String email, String password) async {
    _currentUser = await authRepository.register(email, password);
    // Notify listeners to update the UI
    notifyListeners();
    return _currentUser != null;
  }
  // Login an existing user
  Future<bool> login(String email, String password) async {
    _currentUser = await authRepository.login(email, password);
    // Notify listeners to update the UI
    notifyListeners();
    return _currentUser != null;
  }
  // Logout the current user
  void logout() {
    _currentUser = null;
    // Notify listeners to update the UI
    notifyListeners();
  }
  // Check if the current user is an admin
  bool isAdmin() {
    return _currentUser?.role == 'admin';
  }
  // Check if the current user is authenticated
  bool isAuthenticated() {
    return _currentUser != null;
  }
}
