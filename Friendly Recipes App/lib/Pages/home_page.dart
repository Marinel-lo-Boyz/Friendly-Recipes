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
            // Row(children: <Widget>[buildIcon(), buildTitle(),],),

            buildTitle(),
            SizedBox(
              height: 22,
            ),
            buildSearcher(),
            SizedBox(
              height: 22,
            ),
            buildWeeklyRecipeSection(),
            SizedBox(
              height: 22,
            ),
            buildFilters(),
            // Todo: Change on floating action button scaffold
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
            child: Center(
              child: Transform(
                child: Text(
                  'Weekly Recipe',
                  style: TextStyle(
                      fontFamily: 'Berlin Sans', color: Colors.blueGrey),
                ),
                alignment: FractionalOffset.center,
                transform: Matrix4.identity()..rotateZ(-90 * 3.1415927 / 180),
              ),
            ),
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
