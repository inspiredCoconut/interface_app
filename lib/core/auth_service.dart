import 'package:flutter/material.dart';
import '../data/models/user_model.dart';
import '../data/repositories/auth_repository.dart';

class AuthService extends ChangeNotifier {
  User? _currentUser;
  final AuthRepository authRepository = AuthRepository();

  User? get currentUser => _currentUser;

  Future<bool> login(String email, String password) async {
    _currentUser = await authRepository.login(email, password);
    notifyListeners();
    return _currentUser != null;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  bool isAdmin() {
    return _currentUser?.role == 'admin';
  }

  bool isAuthenticated() {
    return _currentUser != null;
  }
}
