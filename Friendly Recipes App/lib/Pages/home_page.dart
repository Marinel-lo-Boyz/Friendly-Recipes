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
            buildSearcher(),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  children: <Widget>[
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
                      height: 22,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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

  Widget buildSearcher() {
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
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[350],
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(5),
            child: Center(
              child: Text(
                'Weekly Recipe',
                softWrap: false,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Berlin Sans',
                  color: Colors.blueGrey,
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
              buildFilterButton('Starter', Icons.local_dining, Colors.blueGrey),
              buildFilterButton('Main', Icons.restaurant, Colors.blueGrey),
              buildFilterButton('Dessert', Icons.cake, Colors.blueGrey),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        buildFilterButton('Mg', Icons.favorite, Colors.red),
      ],
    );
  }

  Widget buildFilterButton(String filterName, IconData icon, Color color) {
    return Column(
      children: <Widget>[
        Align(
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            child: Icon(
              icon,
              color: color,
              size: 30,
            ),
            onPressed: () {},
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
    return StreamBuilder<QuerySnapshot>(
      stream: db.collection('recipes').orderBy('name').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        List<DocumentSnapshot> recipes = snapshot.data.documents;
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
    return InkWell(
      onTap: () {},
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
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
                )
              ],
            ),
          ),
        ),
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
          onPressed: () {},
        ),
      ),
    );
  }
}
