import 'package:flutter/cupertino.dart';

class FavoriteRecipes with ChangeNotifier{
  List<String> listRecipes = [];

  updateList()
  {
    listRecipes.clear();
  }

}