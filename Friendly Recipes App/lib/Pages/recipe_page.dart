import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:friendly_recipes_app/pages/home_page.dart';

class RecipePage extends StatefulWidget {
  @override
  _RecipePage createState() => _RecipePage();
}

class _RecipePage extends State<RecipePage> {
  bool fav = false;
  dynamic _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Widget _foodimage(dynamic _image, double _maxheigh) {
    //, double _maxwidth) {
    return Image(
      image: FileImage(_image),

      height: _maxheigh,
      //width: _maxwidth,
      fit: BoxFit.fill,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //return Provider<Recipe>.value(
      //value: recipe,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              '',
              style: TextStyle(fontSize: 20),
            ),
            // leading: Icon(Icons.arrow_back_ios, color: Colors.white,),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            )),
        body: Stack(
          children: <Widget>[
            //background image
            Positioned.fill(
              child: Image(
                image: AssetImage('assets/food.jpg'),
                fit: BoxFit.fill,
              ),
            ),

            //text info
            _Info(),
            Row(
              children: <Widget>[
                SizedBox(width: 30),
                Column(
                  children: <Widget>[
                    SizedBox(height: 100),
                    _image == null ? new Text('') : _foodimage(_image, 250),
                    
                    // new Text(Image.file(_image).width.toString(),
                    //     style: TextStyle(fontSize: 90)),
                  ],
                )
              ],
            ),

            Column(children: <Widget>[
              Container(
                height: 350,
              ),
              (fav)
                  ? Container(
                      margin: EdgeInsets.only(right: 235),
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            fav = !fav;
                          });
                        },
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(right: 235),
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.grey,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            fav = !fav;
                          });
                        },
                      ),
                    ),
            ]),
            //bottom button
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 708,
                ),
                SizedBox(
                  height: 75,
                  child: FlatButton.icon(
                    color: Colors.deepOrange[400],
                    shape: StadiumBorder(),
                    label: Text(
                      "Add Picture",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        // fontFamily: 'Berlin Sans',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: () {
                      getImage();
                    },
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

class _Info extends StatefulWidget {
  const _Info({
    Key key,
    //@required this.recipe,
  }) : super(key: key);

  @override
  __InfoState createState() => __InfoState();
}

class __InfoState extends State<_Info> {
  Widget _text(String text) {
    final TextStyle infoStyle = TextStyle(
      fontSize: 17,
      color: Colors.deepOrange[300],
    );
    return Text(text, style: infoStyle);
  }

  Widget _iconText(IconData icon, String text) {
    final Icon icono = Icon(
      icon,
      color: Colors.deepOrange[300],
      size: 20,
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
      margin: EdgeInsets.only(top: 385, bottom: 35),
      padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            Text(
              "Pizza de hojaldre", //recipe.title,
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
                SizedBox(height: 15),
                _iconText(Icons.person, "Alejandro"), //recipe.user),
                SizedBox(height: 20),
                _iconText(Icons.local_dining, "Starter"), //recipe.location),
                SizedBox(height: 20),
                _iconText(Icons.calendar_today,
                    "15:00, el 26 Enero 2020"), //recipe.date),
                SizedBox(height: 35),

                Text(
                  "Ingredients",
                  style: TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(200, 86, 61, 94),
                      fontWeight: FontWeight.bold),
                ),
                Divider(thickness: 1),
                Text(
                  "Amor, Cosas bonitas, Azucar, Ingrediente secreto", //recipe.description,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(200, 86, 61, 94),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Elaboration",
                  style: TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(200, 86, 61, 94),
                      fontWeight: FontWeight.bold),
                ),
                Divider(thickness: 1),
                Text(
                  "Pillas la masa del merca, xd, y despues te la llevas pa tu kelly pa ponerle el tomatico el quesillo y las vaynas que quieras meterle por ensima. La metes pal hornico y a mirar un ratillo para aser ver que todo va bien. Para finalisar, cogemos a la parienta y (corten). Para finalisar cogemos los guantesicos de la iaia y la sacamos sin quemarnos yuis, y ya ta, una croquitatah y palaboca. caproveche!", //recipe.description,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(200, 86, 61, 94),
                  ),
                ),

                SizedBox(height: 20),
                Divider(
                  thickness: 2,
                ),
                Text(
                  "Bon appétit!",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(200, 86, 61, 94),
                      fontWeight: FontWeight.bold),
                ),
                Divider(
                  thickness: 2,
                ),
                SizedBox(height: 50),
              ],
            )
          ],
        ),
      ),
    );
  }
}
