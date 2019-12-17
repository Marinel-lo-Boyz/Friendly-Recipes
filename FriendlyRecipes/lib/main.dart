import 'package:exemples/pages/RecipeListPage.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(FoodRecipeApp());
}

class FoodRecipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        home: FoodRecipeListPage(),
    );
  }
}
