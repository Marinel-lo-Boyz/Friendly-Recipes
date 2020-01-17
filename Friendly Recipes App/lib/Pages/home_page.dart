import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:friendly_recipes_app/Providers/recipe_filters.dart';
import 'package:friendly_recipes_app/pages/recipe_page.dart';
import 'package:provider/provider.dart';

import 'add_recipe_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return buildBase(context);
  }

  Widget buildBase(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView(
              padding: EdgeInsets.only(right: 35, left: 35, top: 20),
              children: <Widget>[
                SizedBox(
                  height: 130,
                ),
                buildWeeklyRecipeSection(),
                SizedBox(
                  height: 22,
                ),
                buildFilters(),
                SizedBox(
                  height: 22,
                ),
                buildRecipesList(),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 18,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                buildTitle(),
                SizedBox(
                  height: 22,
                ),
                buildSearcher(searchController),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: buildAddRecipeButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            height: 46,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8.0, // has the effect of softening the shadow
                  spreadRadius: 5.0, // has the effect of extending the shadow
                  offset: Offset(-6.0, 6.0),
                )
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 22),
                  ),
                  buildIcon(),
                  Center(
                    child: Text(
                      'Friendly Recipes',
                      style: TextStyle(
                          fontFamily: 'Berlin Sans',
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildIcon() {
    return Image(
      image: AssetImage('assets/icon.png'),
      height: 50,
      fit: BoxFit.fill,
    );
  }

  Widget buildSearcher(TextEditingController searchController) {
    RecipeFilters recipeFilters = Provider.of<RecipeFilters>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                color: Colors.grey[350],
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                onChanged: (text) => recipeFilters.searchText = text,
                controller: searchController,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  hintText: 'Search your recipe',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWeeklyRecipeSection() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20.0, // has the effect of softening the shadow
                  spreadRadius: 4.0, // has the effect of extending the shadow
                  offset: Offset(0, 10.0),
                )
              ],
            ),
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(5),
              child: Center(
                child: Text(
                  'Weekly Recipe',
                  softWrap: false,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Berlin Sans',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildFilters() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              buildFilterButton(
                  'Starter', Icons.local_dining, Colors.blueGrey, 'Starter'),
              buildFilterButton(
                  'Main', Icons.restaurant, Colors.blueGrey, 'Main'),
              buildFilterButton(
                  'Dessert', Icons.cake, Colors.blueGrey, 'Dessert'),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        buildFilterButton('Fav', Icons.favorite, Colors.red, 'Fav'),
      ],
    );
  }

  Widget buildFilterButton(
      String filterName, IconData icon, Color color, String heroTag) {
    RecipeFilters recipeFilters = Provider.of<RecipeFilters>(context);

    return Column(
      children: <Widget>[
        Align(
          child: FloatingActionButton(
            heroTag: heroTag,
            backgroundColor: (recipeFilters.filters[filterName] == true
                ? Colors.orange
                : Colors.white),
            child: Icon(
              icon,
              color: (recipeFilters.filters[filterName] == true
                  ? Colors.white
                  : Colors.blueGrey),
              size: 30,
            ),
            onPressed: () {
              recipeFilters.swapFilter(filterName);
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        //Text not necessary yet)
        Text(filterName,
            style: TextStyle(
              fontSize: 13,
              color: Colors.blueGrey,
              fontFamily: 'Berlin Sans',
            )),
      ],
    );
  }

  Widget buildRecipesList() {
    final db = Firestore.instance;
    RecipeFilters recipeFilters = Provider.of<RecipeFilters>(context);

    return StreamBuilder<QuerySnapshot>(
      stream: db.collection('recipes').orderBy('name').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        List<DocumentSnapshot> recipes = snapshot.data.documents;

        // Aplly filters -----------------------------------

        bool noFilterActive = true;

        recipeFilters.filters.forEach((k, v) {
          if (v == true) {
            noFilterActive = false;
          }
        });

        if (!noFilterActive) {
          recipeFilters.filters.forEach((k, v) {
            if (v == false) {
              recipes.removeWhere((doc) => doc.data['type'] == k);
            }
          });
        }

        if (recipeFilters.searchText != '') {
          recipes.removeWhere((doc) {
            String name = doc.data['name'];
            String search = recipeFilters.searchText;
            name = name.toLowerCase();
            search = search.toLowerCase();
            return !name.contains(search);
          });
        }

        // Build list ----------------------------------------

        return ListView.separated(
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 30,
            );
          },
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            return buildRecipeTile(recipes[index]);
          },
        );
      },
    );
  }

  Widget buildRecipeTile(DocumentSnapshot recipe) {
    double heightTile = 120;
    BorderRadius radiusTile = BorderRadius.circular(20);

    return Container(
      decoration: BoxDecoration(
        borderRadius: radiusTile,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20.0, // has the effect of softening the shadow
            spreadRadius: 4.0, // has the effect of extending the shadow
            offset: Offset(0, 10.0),
          )
        ],
      ),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            height: heightTile,
            decoration: BoxDecoration(
              borderRadius: radiusTile,
              color: Colors.white,
            ),
            child: Row(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          'https://www.laespanolaaceites.com/wp-content/uploads/2019/06/pizza-con-chorizo-jamon-y-queso-1080x671.jpg',
                          fit: BoxFit.fitHeight,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        recipe.data['name'],
                        style: TextStyle(
                          fontFamily: 'Berlin Sans',
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Icon(
                                Icons.person,
                                size: 14,
                                color: Colors.black12,
                              ),
                            ),
                            TextSpan(
                              style: TextStyle(color: Colors.black12),
                              text: "  User",
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Icon(
                                Icons.cake,
                                size: 14,
                                color: Colors.black12,
                              ),
                            ),
                            TextSpan(
                              style: TextStyle(color: Colors.black12),
                              text: "  Dessire",
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Material(
            // InkWell Upside
            color: Colors.transparent,
            borderRadius: radiusTile,
            child: InkWell(
              borderRadius: radiusTile,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => RecipePage(), //number that changes
                  ),
                );
              },
              child: Container(
                height: heightTile,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // child: Text(
  //   recipe.data['name'],
  //   style: TextStyle(fontWeight: FontWeight.bold),
  // ),
  Widget buildAddRecipeButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 7.0, // has the effect of softening the shadow
            spreadRadius: 2.0, // has the effect of extending the shadow
            offset: Offset(-5, 8),
          )
        ],
      ),
      child: SizedBox(
        height: 65,
        child: FlatButton.icon(
          color: Colors.white,
          shape: StadiumBorder(),
          label: Text(
            "Add Recipe",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Berlin Sans',
              fontSize: 28,
              color: Colors.blueGrey,
            ),
          ),
          icon: Icon(
            Icons.add,
            color: Colors.blueGrey,
            size: 50,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AddRecipePage(), //number that changes
              ),
            );
          },
        ),
      ),
    );
  }
}
