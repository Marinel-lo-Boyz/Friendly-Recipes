import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:friendly_recipes_app/Providers/user_data.dart';
import 'package:friendly_recipes_app/Widgets/shaded_container.dart';
import 'package:friendly_recipes_app/Widgets/shaded_flat_button.dart';
import 'package:friendly_recipes_app/Widgets/small_feature_text.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:friendly_recipes_app/Providers/recipe_filters.dart';
import 'package:friendly_recipes_app/Widgets/custom_text_field.dart';
import 'package:friendly_recipes_app/pages/recipe_page.dart';

import 'add_recipe_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final db = Firestore.instance;
  RecipeFilters recipeFilters;
  UserData userData;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    recipeFilters = Provider.of<RecipeFilters>(context);
    userData = Provider.of<UserData>(context);

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
                CustomTextField('Serach your recipe', Icons.search,
                    (text) => recipeFilters.searchText = text),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: ShadedFlatButton('Add Recipe', () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AddRecipePage(), //number that changes
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: ShadedContainer(
            borderRadius: BorderRadius.circular(12),
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

  Widget buildWeeklyRecipeSection() {
    double heightTile = 120;
    BorderRadius radiusTile = BorderRadius.circular(20);

    return ShadedContainer(
      borderRadius: radiusTile,
      child: SizedBox(
          height: heightTile,
          child: StreamBuilder<DocumentSnapshot>(
              stream:
                  db.collection('info').document('weeklyRecipe').snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot_1) {
                if (!snapshot_1.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  String id = snapshot_1.data['id'];
                  return StreamBuilder<DocumentSnapshot>(
                      stream: db.collection('recipes').document(id).snapshots(),
                      builder: (context,
                          AsyncSnapshot<DocumentSnapshot> snapshot_2) {
                        if (!snapshot_2.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        DocumentSnapshot recipe = snapshot_2.data;
                        return FlatButton(
                          color: Colors.white,
                          padding: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
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
                                        (recipe.data['url_image'] != null)
                                            ? recipe.data['url_image']
                                            : 'https://media-cdn.tripadvisor.com/media/photo-s/18/1a/d5/1e/casteloes.jpg',
                                        fit: BoxFit.cover,
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
                                    Row(
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
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SmallFeatureText(
                                      recipe.data['user'],
                                      Icons.person,
                                    ),
                                    SmallFeatureText(
                                      recipe.data['type'],
                                      Icons.cake,
                                    ),
                                     SmallFeatureText(
                                      recipe.data['type'],
                                      Icons.cake,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => RecipePage(Info(
                                    recipe.data['name'],
                                    recipe.data['type'],
                                    recipe.data['user'],
                                    recipe.data['time'],
                                    recipe.data['ingredients'],
                                    recipe.data['elaboration'],
                                    recipe.documentID,
                                    recipe.data['url_image'])),
                              ),
                            ); //number that changesnumber that changes
                          },
                        );
                      });
                }
              })),
    );
  }

  // Widget buildWeeklyRecipeSection() {
  //   return StreamBuilder<DocumentSnapshot>(
  //       stream: db.collection('info').document('weeklyRecipe').snapshots(),
  //       builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot_1) {
  //         if (!snapshot_1.hasData) {
  //           return Center(child: CircularProgressIndicator());
  //         } else {
  //           String id = snapshot_1.data['id'];
  //           return StreamBuilder<DocumentSnapshot>(
  //               stream: db.collection('recipes').document(id).snapshots(),
  //               builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot_2) {
  //                 if (!snapshot_2.hasData) {
  //                   return Center(child: CircularProgressIndicator());
  //                 }
  //                 DocumentSnapshot recipe = snapshot_2.data;
  //                 return Row(
  //                   children: <Widget>[
  //                     Expanded(
  //                       child: Container(
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(20),
  //                           boxShadow: [
  //                             BoxShadow(
  //                               color: Colors.black12,
  //                               blurRadius:
  //                                   18.0, // has the effect of softening the shadow
  //                               spreadRadius:
  //                                   3.0, // has the effect of extending the shadow
  //                               offset: Offset(0, 10.0),
  //                             )
  //                           ],
  //                         ),
  //                         child: Container(
  //                           height: 120,
  //                           child: Material(
  //                             child: InkWell(
  //                               onTap: () {
  //                                 Navigator.of(context).push(
  //                                   MaterialPageRoute(
  //                                     builder: (_) => RecipePage(Info(
  //                                         recipe.data['name'],
  //                                         recipe.data['type'],
  //                                         recipe.data['user'],
  //                                         recipe.data['time'],
  //                                         recipe.data['ingredients'],
  //                                         recipe.data['elaboration'],
  //                                         recipe.documentID,
  //                                         recipe.data['url_image'])),
  //                                   ),
  //                                 );
  //                               },
  //                               child: Row(
  //                                 children: <Widget>[
  //                                   AspectRatio(
  //                                     aspectRatio: 1,
  //                                     child: Container(
  //                                       width: 100,
  //                                       height: 100,
  //                                       decoration: BoxDecoration(
  //                                         color: Colors.orange,
  //                                         borderRadius:
  //                                             BorderRadius.circular(15),
  //                                       ),
  //                                       child: ClipRRect(
  //                                           borderRadius:
  //                                               BorderRadius.circular(15),
  //                                           child: Image.network(
  //                                             'https://www.laespanolaaceites.com/wp-content/uploads/2019/06/pizza-con-chorizo-jamon-y-queso-1080x671.jpg',
  //                                             fit: BoxFit.fitHeight,
  //                                           )),
  //                                     ),
  //                                   ),
  //                                   Padding(
  //                                     padding: const EdgeInsets.symmetric(
  //                                       horizontal: 15,
  //                                       vertical: 10,
  //                                     ),
  //                                     child: Column(
  //                                       mainAxisAlignment:
  //                                           MainAxisAlignment.start,
  //                                       crossAxisAlignment:
  //                                           CrossAxisAlignment.start,
  //                                       children: <Widget>[
  //                                         Row(
  //                                           children: <Widget>[
  //                                             Text(
  //                                               //'name',
  //                                               snapshot_2.data['name'],
  //                                               style: TextStyle(
  //                                                 fontFamily: 'Berlin Sans',
  //                                                 color: Colors.blueGrey,
  //                                                 fontWeight: FontWeight.bold,
  //                                                 fontSize: 18,
  //                                               ),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                         SizedBox(
  //                                           height: 10,
  //                                         ),
  //                                         SmallFeatureText(
  //                                           'User',
  //                                           Icons.person,
  //                                         ),
  //                                         SmallFeatureText(
  //                                           'Type',
  //                                           Icons.cake,
  //                                         ),
  //                                         SmallFeatureText(
  //                                           'Time',
  //                                           Icons.calendar_today,
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   )
  //                                 ],
  //                               ),
  //                             ),
  //                             color: Colors.transparent,
  //                           ),
  //                           color: Colors.orange,
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 );
  //               });
  //         }
  //       });
  // }

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
              buildFilterButton('Starter', Icons.local_dining),
              buildFilterButton('Main', Icons.restaurant),
              buildFilterButton('Dessert', Icons.cake),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        buildFilterButton('Fav', Icons.favorite),
      ],
    );
  }

  Widget buildFilterButton(String filterName, IconData icon) {
    return Column(
      children: <Widget>[
        Align(
          child: FloatingActionButton(
            heroTag: filterName,
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
          if (v == true && k != 'Fav') {
            noFilterActive = false;
          }
        });

        if (recipeFilters.filters['Fav'] == true) {
          recipes.removeWhere((doc) => !userData.isFavorite(doc.documentID));
        }

        if (!noFilterActive) {
          recipeFilters.filters.forEach(
            (k, v) {
              if (v == false) {
                if (k != 'Fav') {
                  recipes.removeWhere((doc) => doc.data['type'] == k);
                }
              }
            },
          );
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

    return ShadedContainer(
      borderRadius: radiusTile,
      child: SizedBox(
        height: heightTile,
        child: FlatButton(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
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
                        (recipe.data['url_image'] != null)
                            ? recipe.data['url_image']
                            : 'https://media-cdn.tripadvisor.com/media/photo-s/18/1a/d5/1e/casteloes.jpg',
                        fit: BoxFit.cover,
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
                    Row(
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
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SmallFeatureText(
                      recipe.data['user'],
                      Icons.person,
                    ),
                    SmallFeatureText(
                      recipe.data['type'],
                      Icons.cake,
                    ),
                  ],
                ),
              )
            ],
          ),
          onLongPress: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // return object of type Dialog
                return AlertDialog(
                  title: new Text("Delete recipe"),
                  content: new Text("Recipe can not be recovered"),
                  actions: <Widget>[
                    // usually buttons at the bottom of the dialog
                    new FlatButton(
                      child: new Text("Close"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    new FlatButton(
                      child: new Text("Delete"),
                      onPressed: () {
                        final db = Firestore.instance;
                        db
                            .collection('recipes')
                            .document(recipe.documentID)
                            .delete();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => RecipePage(Info(
                    recipe.data['name'],
                    recipe.data['type'],
                    recipe.data['user'],
                    recipe.data['time'],
                    recipe.data['ingredients'],
                    recipe.data['elaboration'],
                    recipe.documentID,
                    recipe.data['url_image'])),
              ),
            ); //number that changesnumber that changes
          },
        ),
      ),
    );
  }
}
