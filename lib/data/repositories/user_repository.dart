import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import 'package:flutter/services.dart' show rootBundle;

class UserRepository {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/users';

  Future<List<User>> fetchUsers() async {
    final response = await http
        .get(Uri.parse(apiUrl), headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      return jsonData.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load users");
    }
  }

  Future<List<User>> loadJsonUsers() async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/users.json');
      List jsonData = json.decode(response);
      return jsonData.map((e) => User.fromJson(e)).toList();
    } catch (e) {
      print(e);
      throw Exception("Failed to load users");
    }
  }

  Future<User> createUser(String name, String email) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email}),
    );

    if (response.statusCode == 201) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to create user");
    }
  }

  Future<User> updateUser(int id, String name, String email) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email}),
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to update user");
    }
  }

  Future<void> deleteUser(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception("Failed to delete user");
    }
  }
}
