import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

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

  // Fake login for demo using json file
  Future<User?> fakeLogin() async {
    final String response =
        await rootBundle.loadString('assets/json/user_demo.json');
    return User.fromJson(json.decode(response));
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

  // Update the current user's profile
  Future<User?> updateProfile(String email, String name, int age) async {
    final response = await http.put(
      Uri.parse(Endpoints.updateProfileUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'name': name, 'age': age}),
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }
}
