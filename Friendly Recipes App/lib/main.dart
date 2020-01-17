import 'package:flutter/material.dart';
import 'package:friendly_recipes_app/Pages/home_page.dart';
import 'package:friendly_recipes_app/Providers/recipe_filters.dart';
import 'package:provider/provider.dart';

import 'Pages/user_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RecipeFilters(),)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: UserPage(),
      ),
      
    );
  }
}
