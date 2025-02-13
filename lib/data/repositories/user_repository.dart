import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import 'package:flutter/services.dart' show rootBundle;

class UserRepository {
  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    
    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      return jsonData.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load users");
    }
  }

  Future<List<User>> loadJsonUsers() async {
    try {
      final String response = await rootBundle.loadString('assets/json/users.json');
      List jsonData = json.decode(response);
      return jsonData.map((e) => User.fromJson(e)).toList();
    } catch (e) {
      print(e);
      throw Exception("Failed to load users");
    }
  }
}
