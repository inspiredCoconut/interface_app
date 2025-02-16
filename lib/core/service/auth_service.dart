import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';

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

  // Fake login for demo using json file
  Future<bool> fakeLogin(String email, String password) async {
    _currentUser = await authRepository.fakeLogin();
    // Notify listeners to update the UI
    notifyListeners();
    return _currentUser != null;
  }

  // Update the current user's profile
  Future<bool> updateProfile(String email, String name, int age) async {
    _currentUser = await authRepository.updateProfile(email, name, age);
    // Notify listeners to update the UI
    notifyListeners();
    return _currentUser != null;
  }

  // Fake update profile for only changes model
  Future<bool> fakeUpdateProfile(String email, String name, int age) async {
    int id = _currentUser?.id ?? 0;
    String role = _currentUser?.role ?? 'user';

    _currentUser = User(id: id, email: email, name: name, age: age, role: role);
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
