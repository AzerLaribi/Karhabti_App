import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class Transaction {
  late String id;
  late String title;
  late double amount;
  late DateTime date;
  bool isFavorite;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    this.isFavorite = false,
  });
  void _setFavValue(bool newValue) {
    isFavorite = newValue;
  }

  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    final url = Uri.parse(
      'https://test-1dc4e-default-rtdb.firebaseio.com/Transaction/${FirebaseAuth.instance.currentUser?.uid}/transaction.json',
    );
    try {
      final response = await http.patch(
        url,
        body: json.encode({
          'isFavorite': isFavorite,
        }),
      );
      print(isFavorite);
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
