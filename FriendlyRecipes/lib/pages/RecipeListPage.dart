import 'package:exemples/info/recipe.dart';
import 'package:exemples/pages/FavouriteListPage.dart';
import 'package:exemples/pages/RecipePage.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'package:path_provider/path_provider.dart';

class FoodRecipeListPage extends StatefulWidget {
  @override
  _FoodRecipeListPage createState() => _FoodRecipeListPage();
}

class _FoodRecipeListPage extends State<FoodRecipeListPage> {
  List<Recipe> _recipes;

  //  @override
  //  void initState() {
  //    loadRecipeList();
  //    super.initState();
  //  }

  @override
  void initState() {
    loadRecipeList().then((recipes) {
      setState(() => _recipes = recipes);
    });
    super.initState();
  }

  Icon getIcon(bool favourite) {
    if (favourite) {
      return Icon(Icons.favorite);
    } else {
      return Icon(Icons.favorite_border);
    }
  }

  @override
  Widget build(BuildContext context) {
    //List<Recipe> _recipes = Provider.of<List<Recipe>>(context);
    if (_recipes == null) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe List'),
      ),
      body: ListView.separated(
        itemCount: _recipes.length,
        itemBuilder: (context, index) {
          //final Recipe recipe = Provider.of<RecipeList>(context).recipes[index];
          return ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => FoodRecipe(_recipes[index]),
                ),
              );
            },
            title: Text(_recipes[index].title),
            trailing: IconButton(
              icon: getIcon(_recipes[index].favourite),
              onPressed: () {},
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[300],
            height: 1,
          );
        },
    ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        child: Icon(Icons.favorite),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FavoriteScreenList(),
            ),
          );
        },
      ),
    );
  }
}
