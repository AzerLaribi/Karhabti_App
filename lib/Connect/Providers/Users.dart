import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Users with ChangeNotifier {
  final String id;
  final String name;
  final String email;
  final String password;
  Users({
    required this.email,
    required this.id,
    required this.name,
    required this.password,
  });
  List<Users> _items = [];
  Future<void> fetchAndSetUsers(String link) async {
    final url =
        Uri.parse(link);
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Users> loadedUsers = [];
      extractedData.forEach((userId, userData) {
        loadedUsers.add(Users(
          id: userId,
          name: userData['name'],
          email: userData['email'],
          password: userData['password'],
        ));
      });
      _items = loadedUsers;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<String> getUser(String email) async {
    final user = _items.firstWhere((user) => user.email == email);
    return user.name;
  }
}
