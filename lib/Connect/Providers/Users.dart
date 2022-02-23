import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Users with ChangeNotifier {
  final String id;
  final String name;
  final String email;
  final String password;
  final String genre;
  final String naissance;
  final String photoProfilUrl;
  final String numTel;
  final String adress;
  final String vehiculeId;
  final String ReviewId;
  final String FavoritesId;
  Users({
    required this.genre,
    required this.naissance,
    required this.photoProfilUrl,
    required this.numTel,
    required this.adress,
    required this.vehiculeId,
    required this.ReviewId,
    required this.FavoritesId,
    required this.email,
    required this.id,
    required this.name,
    required this.password,
  });
  List<Users> _items = [];
  // Future<void> fetchAndSetUsers() async {
  //   final url =
  //       Uri.parse('https://test-1dc4e-default-rtdb.firebaseio.com/users.json');
  //   try {
  //     final response = await http.get(url);
  //     final extractedData = json.decode(response.body) as Map<String, dynamic>;
  //     if (extractedData == null) {
  //       return;
  //     }
  //     final List<Users> loadedUsers = [];
  //     extractedData.forEach((userId, userData) {
  //       loadedUsers.add(
  //         Users(
  //           id: userId,
  //           name: userData['name'],
  //           email: userData['email'],
  //           password: userData['password'],
  //           adress: userData['adress'],
  //           genre: userData['genre'],
  //           FavoritesId: userData['FavoritesId'],
  //           naissance: userData['naissance'],
  //           numTel: userData['numTel'],
  //           photoProfilUrl: userData['photoProfilUrl'],
  //           ReviewId: userData['ReviewId'],
  //           vehiculeId: userData['vehiculeId'],
  //         ),
  //       );
  //     });
  //     _items = loadedUsers;
  //     notifyListeners();
  //   } catch (error) {
  //     throw (error);
  //   }
  // }

  // Future<String> getUser(String email) async {
  //   final user = _items.firstWhere((user) => user.email == email);
  //   return user.name;
  // }

  // Future<void> addUser(Users user) async {
  //   final url = Uri.parse(
  //     'https://test-1dc4e-default-rtdb.firebaseio.com/users.json',
  //   );
  //   try {
  //     final response = await http.post(
  //       url,
  //       body: json.encode({
  //         id: user.id,
  //         name: user.name,
  //         email: user.email,
  //         password: user.password,
  //         adress: user.adress,
  //         genre: user.genre,
  //         FavoritesId: '0',
  //         naissance: user.naissance,
  //         numTel: user.numTel,
  //         photoProfilUrl: user.photoProfilUrl,
  //         ReviewId: user.ReviewId,
  //         vehiculeId: user.vehiculeId,
  //       }),
  //     );
  //     final newUser = Users(
  //       id: user.id,
  //       name: user.name,
  //       email: user.email,
  //       password: user.password,
  //       adress: user.adress,
  //       genre: user.genre,
  //       FavoritesId: user.FavoritesId,
  //       naissance: user.naissance,
  //       numTel: user.numTel,
  //       photoProfilUrl: user.photoProfilUrl,
  //       ReviewId: user.ReviewId,
  //       vehiculeId: user.vehiculeId,
  //     );
  //     _items.add(newUser);
  //     // _items.insert(0, newProduct); // at the start of the list
  //     notifyListeners();
  //   } catch (error) {
  //     print(error);
  //     throw error;
  //   }
  // }

  // Future<Iterable<Users>> findById(String userId) async {
  //   final url =
  //       Uri.parse('https://test-1dc4e-default-rtdb.firebaseio.com/users.json');
  //   try {
  //     final response = await http.get(url);
  //     final extractedData = json.decode(response.body) as Map<String, dynamic>;
  //     if (extractedData != null) {
  //       final List<Users> loadedUsers = [];
  //       extractedData.forEach((prodId, prodData) {
  //         loadedUsers.add(Users(
  //           id: prodId,
  //           adress: prodData['adress'],
  //           email: prodData['email'],
  //           FavoritesId: prodData['FavoritesId'],
  //           genre: prodData['genre'],
  //           naissance: prodData['naissance'],
  //           name: prodData['name'],
  //           numTel: prodData['numTel'],
  //           password: prodData['password'],
  //           photoProfilUrl: prodData['photoProfilUrl'],
  //           ReviewId: prodData['ReviewId'],
  //           vehiculeId: prodData['vehiculeId'],
  //         ));
  //       });
  //       return loadedUsers.where((user) => user.id == userId);
  //     }
  //   } catch (error) {
  //     print(error);
  //   }
  //   return [];
  // }

}
