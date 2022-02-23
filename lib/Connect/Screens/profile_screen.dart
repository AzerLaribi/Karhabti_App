import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:karhabti_app/Connect/Screens/ConnectScreen.dart';
import 'package:karhabti_app/Connect/Screens/SignIn_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import '../Providers/Users.dart';

import 'dart:developer' as devtools;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

List<Users> _items = [];
Future<void> fetchAndSetUsers() async {
  final url =
      Uri.parse('https://test-1dc4e-default-rtdb.firebaseio.com/users.json');
  try {
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    final List<Users> loadedUsers = [];
    extractedData.forEach((userId, userData) {
      loadedUsers.add(
        Users(
          id: userData['id'],
          name: userData['name'],
          email: userData['email'],
          password: userData['password'],
          adress: userData['adress'],
          genre: userData['genre'],
          FavoritesId: userData['FavoritesId'],
          naissance: userData['naissance'],
          numTel: userData['numTel'],
          photoProfilUrl: userData['photoProfilUrl'],
          ReviewId: userData['ReviewId'],
          vehiculeId: userData['vehiculeId'],
        ),
      );
    });
    _items = loadedUsers;
    print(extractedData);
  } catch (error) {
    print(error);
  }
}

// Future<Object> findById(userId) async {
//   var _items = [];
//   final url =
//       Uri.parse('https://test-1dc4e-default-rtdb.firebaseio.com/users.json');
//   try {
//     final response = await http.get(url);
//     final extractedData = json.decode(response.body) as Map<String, dynamic>;
//     final List loadedUsers = [];
//     (extractedData.values.forEach((element) {
//       loadedUsers.add(element.toString());
//     }));
//     extractedData.forEach((id, prodData) {
//       if (prodData['email'] == FirebaseAuth.instance.currentUser?.email)
//         loadedUsers.add(prodData);
//     });
//     print(loadedUsers);
//   } catch (error) {
//     print(error);
//   }
//   // print('object');
//   return [];
// }

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = fetchAndSetUsers();
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text('Profile'),
      ),
      body: Text('profile'),
    );
  }
}
