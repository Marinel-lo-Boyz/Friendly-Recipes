import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserData with ChangeNotifier {
  DocumentSnapshot document;
  List<String> favoriteIds = [];
  final db = Firestore.instance;

  updateList() {
    favoriteIds.clear();
  }

  bool isFavorite(String id) {
    return favoriteIds.contains(id);
  }

  addFavorite(String id) {
    favoriteIds.add(id);
    db.collection('users').document(document.documentID).updateData({
      'favorites': favoriteIds,
    });
  }

  removeFavorite(String id) {
    favoriteIds.remove(id);
    db.collection('users').document(document.documentID).updateData({
      'favorites': favoriteIds,
    });
  }
}
