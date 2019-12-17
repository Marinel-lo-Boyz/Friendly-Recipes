import 'package:exemples/info/recipe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodRecipe extends StatelessWidget {
  final Recipe recipe;
  FoodRecipe(this.recipe);
  // RecipeFavList _recipeFavList;

  // @override
  // void initState() {
  //   loadRecipeFavList().then((recipes) {
  //     setState(() => _recipeFavList = recipes);
  //   });
  //   super.initState();
  // }

  Widget _floatingbutton(double height1, double rightMargin, Color bgColor,
      IconData icon, Color iconColor, double sizeIcon) {
    final dynamic container = Container(
      margin: EdgeInsets.only(right: rightMargin), //235
      child: FloatingActionButton(
        backgroundColor: bgColor,
        child: Icon(
          icon,
          color: iconColor,
          size: sizeIcon,
        ),
        onPressed: () {},
      ),
    );

    return Column(children: <Widget>[
      Container(
        height: height1,
      ),
      container,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Provider<Recipe>.value(
      value: recipe,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            //background image
            Positioned.fill(
              child: Image(
                image: AssetImage(recipe.basePhoto),
                fit: BoxFit.fill,
              ),
            ),
            //return button
            _floatingbutton(0, 335, Colors.deepOrange[300], Icons.chevron_left,
                Colors.white, 20),
            //text info
            _Info(recipe: recipe),
            //favourite button
            //_FavoriteButton(this),
            Column(children: <Widget>[
              Container(
                height: 250,
              ),
              Container(
                margin: EdgeInsets.only(right: 235),
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 30,
                  ),
                  onPressed: () {
                    // setState(() {
                    // _recipeFavList.add(widget._parent.recipe);
                    // });
                  },
                ),
              )
            ]),
            //bottom button
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 540,
                ),
                Expanded(
                  child: FlatButton(
                    color: Colors.deepOrange[400],
                    shape: StadiumBorder(),
                    child: Text(
                      "Beli Tiket",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class _FavoriteButton extends StatefulWidget {
//   final FoodRecipe _parent;
//   _FavoriteButton(this._parent);

//   @override
//   _FavButtonState createState() => _FavButtonState();
// }

// class _FavButtonState extends State<_FavoriteButton> {

//   List<Recipe> _recipeFavList;

//   @override
//    void initState() {
//      loadRecipeFavList().then((recipes) {
//        setState(() => _recipeFavList = recipes);
//      });
//      super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: <Widget>[
//       Container(
//         height: 250,
//       ),
//       Container(
//         margin: EdgeInsets.only(right: 235),
//         child: FloatingActionButton(
//           backgroundColor: Colors.white,
//           child: Icon(
//             Icons.favorite,
//             color: Colors.red,
//             size: 30,
//           ),
//           onPressed: () {
//             // setState(() {
//             // _recipeFavList.add(widget._parent.recipe);
//             // });
//           },
//         ),
//       )
//     ]);
//   }
// }

class _Info extends StatelessWidget {
  const _Info({
    Key key,
    @required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

  Widget _text(String text) {
    final TextStyle infoStyle = TextStyle(
      fontSize: 12,
      color: Colors.deepOrange[300],
    );
    return Text(text, style: infoStyle);
  }

  Widget _iconText(IconData icon, String text) {
    final Icon icono = Icon(
      icon,
      color: Colors.deepOrange[300],
      size: 15,
    );

    return Row(children: <Widget>[
      icono,
      SizedBox(width: 8),
      _text(text),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    //final _recipe = Provider.of<Recipe>(context);
    return Container(
      margin: EdgeInsets.only(top: 285),
      padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          Text(
            recipe.title,
            style: TextStyle(
              fontFamily: 'Bodoni',
              fontWeight: FontWeight.w700,
              fontSize: 42,
              color: Color.fromARGB(255, 60, 22, 48),
            ),
          ),
          SizedBox(height: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _iconText(Icons.location_on, recipe.location),
              SizedBox(height: 10),
              _iconText(Icons.calendar_today, recipe.date),
              SizedBox(height: 12),
              Text(
                recipe.description,
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(200, 86, 61, 94),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
