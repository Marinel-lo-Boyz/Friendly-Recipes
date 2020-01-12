import 'package:friendly_recipes_app/info/recipe.dart';
import 'package:friendly_recipes_app/pages/RecipeListPage.dart';
import 'package:friendly_recipes_app/pages/RecipePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreenList extends StatefulWidget {
  @override
  _FavoriteScreenList createState() => _FavoriteScreenList();
}

class _FavoriteScreenList extends State<FavoriteScreenList> {
  List<Recipe> _recipeFavList;

   @override
   void initState() {
       loadRecipeFavList().then((favrecipes) {
       setState(() => _recipeFavList = favrecipes);
     });
     super.initState();
   }

  _body() {
    //RecipeFavList favrecipes = Provider.of<RecipeFavList>(context);
    //_recipeFavList = favrecipes;
    if (_recipeFavList == null) {
      return Center(
        child: Text(
            "No favorites added, click the favourite Icon to add a receipe to favorites"),
      );
    }
    return ListView.separated(
      itemCount: _recipeFavList.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => FoodRecipe(_recipeFavList[index]),
              ),
            );
          },
          title: Text(_recipeFavList[index].title),
          trailing: IconButton(
            icon: Icon(Icons.favorite),
            onPressed: null,
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey[300],
          height: 1,
          thickness: 1,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Provider<List<Recipe>>.value(
      value: _recipeFavList,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Favorites List'),
        ),
        body: _body(),
        floatingActionButton: FloatingActionButton(
          mini: true,
          child: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FoodRecipeListPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
