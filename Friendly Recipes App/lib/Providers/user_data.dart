import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserData with ChangeNotifier {
  DocumentSnapshot document;
  List<String> _favoriteIds = [];
  final db = Firestore.instance;

  updateList() {
    _favoriteIds = List.from(document.data['favorites']);
  }

  bool isFavorite(String id) {
    return _favoriteIds.contains(id);
  }

  List<String> getFavList() {
    List<String> ret = [];
    if (document != null) {
      db.collection('users').document(document.documentID).get().then(
        (doc) {
          _favoriteIds = List.from(doc.data['favorites']);
        },
      );
      ret = _favoriteIds;
    }

    return ret;
  }

  addFavorite(String id) {
    _favoriteIds.add(id);

    if (document != null) {
      db.collection('users').document(document.documentID).setData({
        'favorites': _favoriteIds,
      }, merge:  true);
    }
  }

  removeFavorite(String id) {
    _favoriteIds.remove(id);
    if (document != null) {
      db.collection('users').document(document.documentID).setData({
        'favorites': _favoriteIds,
      },merge:  true);
    }
  }
}
