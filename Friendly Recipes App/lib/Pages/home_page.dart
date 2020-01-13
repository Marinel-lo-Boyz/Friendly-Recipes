import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:friendly_recipes_app/pages/recipe_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            buildTitle(),
            SizedBox(
              height: 22,
            ),
            buildSearcher(),
            SizedBox(
              height: 22,
            ),
            buildWeeklyRecipeSection(),
          ],
        ),
      ),
    );
  }

  Widget buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 46,
          width: 300,
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
            child: Center(
              child: Text(
                'Friendly Recipes',
                style: TextStyle(
                    fontFamily: 'Berlin Sans',
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black54),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSearcher() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 42,
            decoration: BoxDecoration(
              color: Colors.grey[350],
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
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
    );
  }

  Widget buildWeeklyRecipeSection() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[350],
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }

  
  // @override
  // Widget build(BuildContext context) {
  //   final db = Firestore.instance;
  //   return Scaffold(
  //     body: StreamBuilder<QuerySnapshot>(
  //       stream: db.collection('recipes').orderBy('name').snapshots(),
  //       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //         if (!snapshot.hasData) {
  //           return Center(child: CircularProgressIndicator());
  //         }
  //         List<DocumentSnapshot> recipes = snapshot.data.documents;
  //         return ListView.builder(
  //           itemCount: recipes.length,
  //           itemBuilder: (context, index) {
  //             return InkWell(
  //               onTap: () {
  //                 //Navigator.of(context).pushNamed('BANG');
  //                 Navigator.of(context)
  //                     .push(MaterialPageRoute(builder: (_) => RecipePage()));
  //                 //.push(MaterialPageRoute(builder: (_) => FoodRecipe(_recipes[1])));
  //               },
  //               child: ListTile(
  //                 title: Text(
  //                   recipes[index].data['name'],
  //                   style: TextStyle(fontWeight: FontWeight.bold),
  //                 ),
  //                 subtitle: Text(recipes[index].documentID),
  //               ),
  //             );
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }
}
