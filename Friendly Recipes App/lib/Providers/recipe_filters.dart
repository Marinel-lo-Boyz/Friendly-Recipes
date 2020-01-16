import 'package:flutter/cupertino.dart';

class RecipeFilters with ChangeNotifier {
  String _searchText = '';

  get searchText
  {
    return _searchText;
  }

  set searchText(String name)
  {
    _searchText = name;
    notifyListeners();
  }

  Map<String, bool> filters = {
    'Starter': false,
    'Main': false,
    'Dessert': false,
    'Fav': false,
  };

  swapFilter(String filterName) {
    filters[filterName] = !filters[filterName];
    notifyListeners();
  }
}
