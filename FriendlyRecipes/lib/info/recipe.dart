import 'dart:convert';

import 'package:flutter/services.dart';

class Recipe {
  String title, location, date, description;
  String basePhoto;
  bool favourite;

  Recipe.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    location = json['location'];
    date = json['date'];
    description = json['description'];
    basePhoto = json['basePhoto'];
    favourite = json['favourite'];
  }

  Recipe(this.title, this.location, this.date, this.description, this.basePhoto,
      this.favourite);

  // void addFavRecipe(Recipe r) {
  //   favrecipes.add(r);
  // }
}

class RecipeList {
  List<Recipe> recipes;
  RecipeList(this.recipes);
}

Future<List<Recipe>> loadRecipeList() async {
  try {
    String data = await rootBundle.loadString('assets/recipes.json');
    var json = jsonDecode(data);
    List<Recipe> recipes = [];
    for (var r in json['recipes']) {
      recipes.add(Recipe.fromJson(r));
    }
    return recipes;
  } catch (e) {
    return [];
  }
}

class RecipeFavList {
  List<Recipe> favrecipes;
  RecipeFavList(this.favrecipes);

  void addFavRecipe(Recipe r) {
    favrecipes.add(r);
  }
}

Future<List<Recipe>> loadRecipeFavList() async {
  String data = await rootBundle.loadString('assets/favrecipes.json');
  var json = jsonDecode(data);
  List<Recipe> favrecipes = [];
  for (var r in json['recipes']) {
    favrecipes.add(Recipe.fromJson(r));
  }
  return favrecipes;
}

// final bakery = Recipe(
//   'Solo Bakery Beverage',
//   'Quezon City',
//   '5 Nov 2019',
//   'Konsep templat ini memang seperti itu yang '
//     'mana akan membuat pengunjung dapat lebih'
//     'banyak menghabiskan waktu untuk nongkrong'
//     'berkumpul, bersantai, berdiskusi dan mengobrol'
//     'satu sama lain',
//   'assets/food.jpg',
// );
