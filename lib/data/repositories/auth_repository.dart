import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';
import '../../core/constants/endpoints.dart';

class AuthRepository {
  // Register a new user
  Future<User?> register(String email, String password) async {
    final response = await http.post(
      Uri.parse(Endpoints.registerUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }
  // Login an existing user
  Future<User?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(Endpoints.loginUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }
}
