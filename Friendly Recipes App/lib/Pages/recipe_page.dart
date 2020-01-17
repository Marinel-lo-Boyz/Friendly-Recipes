import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:friendly_recipes_app/Providers/user_data.dart';
import 'package:image_picker/image_picker.dart';
import 'package:friendly_recipes_app/pages/add_recipe_page.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io';

// import 'package:friendly_recipes_app/pages/home_page.dart';
class Info {
  String title,
      type,
      user,
      time,
      ingredients,
      elaboration,
      id,
      documentID,
      url_image;
  Info(this.title, this.type, this.user, this.time, this.ingredients,
      this.elaboration, this.id, this.documentID, this.url_image);
}

class RecipePage extends StatefulWidget {
  //String _title;
  final Info info;
  RecipePage(this.info);
  @override
  _RecipePage createState() => _RecipePage();
}

class _RecipePage extends State<RecipePage> {
  bool fav = false;
  bool weekly = false;
  // TextEditingController _typeCtrl, _userCtrl, _timeCtrl;
  TextEditingController _typeCtrl, _timeCtrl;
  File _image;
  List<Item> _dataType =
      generateItems(1, "Type", ["Starter", "Main", "Dessert"]);
  UserData userData;

  @override
  void initState() {
    _typeCtrl = TextEditingController();
    // _userCtrl = TextEditingController();
    _timeCtrl = TextEditingController();
    super.initState();
  }

  Widget _buildPanel(List<Item> _dataItem, TextEditingController _txtCtrl) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _dataItem[index].isExpanded = !isExpanded;
        });
      },
      children: _dataItem.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: Column(
            children: <Widget>[
              ListTile(
                title: Text(item.expandedValue[0]),
                onTap: () => setState(() {
                  item.headerValue = item.expandedValue[0];
                  _txtCtrl.text = item.expandedValue[0];
                }),
              ),
              ListTile(
                title: Text(item.expandedValue[1]),
                onTap: () => setState(() {
                  item.headerValue = item.expandedValue[1];
                  _txtCtrl.text = item.expandedValue[1];
                }),
              ),
              ListTile(
                title: Text(item.expandedValue[2]),
                onTap: () => setState(() {
                  item.headerValue = item.expandedValue[2];
                  _txtCtrl.text = item.expandedValue[2];
                }),
              ),
            ],
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

  Widget popUpWeekly() {
    return Column(
      children: <Widget>[
        //SizedBox(height: 200,),
        Padding(
          padding: EdgeInsets.all(100),
        ),
        Container(
          color: Colors.blueGrey,
          child: Column(
            children: <Widget>[
              Text(
                'Weekly Recipe',
                style: TextStyle(
                    fontFamily: 'Berlin Sans',
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black54),
              ),
              //SizedBox(height: 200,),
              _buildPanel(_dataType, _typeCtrl),
              // _buildPanel(_dataUsers, _userCtrl),
              TextField(
                controller: _timeCtrl,
                decoration: InputDecoration(labelText: 'Time (ex: 12:45)'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
    _uploadImageFirebase(image);
  }

  Future _uploadImageFirebase(File _image) async {
    String fileName = basename(_image.path);
    StorageReference firebaseStorage =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorage.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    // setState(() {
    //   print("Profile Picture uploaded");
    // });
    final db = Firestore.instance;
    db.collection('recipes').document(widget.info.documentID).setData({
      'url_image': (await firebaseStorage.getDownloadURL()).toString(),
    }, merge: true);

    // if (_image != null) {
    //   var imageName = Uuid().v1();
    //   var imagePath = "/recipes/$_image.jpg";
    //   final StorageReference storageReference =
    //       FirebaseStorage().ref().child(imagePath);
    //   final StorageUploadTask uploadTask = storageReference.putFile(_image);
    //   final StreamSubscription<StorageTaskEvent> streamSubscription =
    //       uploadTask.events.listen((event) {
    //     // You can use this to notify yourself or your user in any kind of way.
    //     // For example: you could use the uploadTask.events stream in a StreamBuilder instead
    //     // to show your user what the current status is. In that case, you would not need to cancel any
    //     // subscription as StreamBuilder handles this automatically.

    //     // Here, every StorageTaskEvent concerning the upload is printed to the logs.
    //     print('EVENT ${event.type}');
    //   });
    //   await uploadTask.onComplete;
    //   streamSubscription.cancel();
    // }
  }

  Widget _foodimage(dynamic _image) {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 12),
          ),
          ClipOval(
            child: SizedBox(
              height: 300,
              width: 300,
              child: Image(
                image: FileImage(_image),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _readImage() {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 12),
          ),
          ClipOval(
            child: SizedBox(
              height: 300,
              width: 300,
              child: Image.network(widget.info.url_image),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    userData = Provider.of<UserData>(context);

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
            _Info(
              info: widget.info,
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 30),
                Column(
                  children: <Widget>[
                    SizedBox(height: 35),
                    if (widget.info.url_image != null) _readImage(),
                  ],
                )
              ],
            ),

            Row(
              children: <Widget>[
                SizedBox(width: 220),
                //Add weeklyRecipe button
                Column(children: <Widget>[
                  Container(
                    height: 350,
                  ),
                  (weekly)
                      ? Container(
                          // margin: EdgeInsets.only(right: 235),
                          child: FloatingActionButton(
                            heroTag: 'weekly',
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              setState(() {
                                weekly = !weekly;
                              });
                            },
                          ),
                        )
                      : Container(
                          // margin: EdgeInsets.only(right: 235),
                          child: FloatingActionButton(
                            heroTag: 'weekly_fill',
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person_add,
                              color: Colors.blueGrey,
                              size: 30,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // return object of type Dialog
                                  return AlertDialog(
                                    title: new Text("Weekly recipe"),
                                    content: new Column(
                                      children: <Widget>[
                                        _buildPanel(_dataType, _typeCtrl),
                                        // _buildPanel(_dataUsers, _userCtrl),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      // usually buttons at the bottom of the dialog
                                      new FlatButton(
                                        child: new Text("Close"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          setState(() {
                                            weekly = !weekly;
                                          });
                                        },
                                      ),
                                      new FlatButton(
                                        child: new Text("Accept"),
                                        onPressed: () {
                                          // final db = Firestore.instance;
                                          // db
                                          //     .collection('recipes')
                                          //     .document(recipe.documentID)
                                          //     .delete();
                                          // Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                              setState(() {
                                weekly = !weekly;
                              });
                            },
                          ),
                        ),
                ]),

                SizedBox(
                  width: 10,
                ),

                Column(children: <Widget>[
                  Container(
                    height: 350,
                  ),
                  Container(
                    //margin: EdgeInsets.only(right: 235),
                    child: FloatingActionButton(
                      heroTag: 'favorite',
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.favorite_border,
                        color: (userData.isFavorite(widget.info.id))
                            ? Colors.red
                            : Colors.blueGrey,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          if (userData.isFavorite(widget.info.id)) {
                            userData.removeFavorite(widget.info.id);
                          } else {
                            userData.addFavorite(widget.info.id);
                          }
                        });
                      },
                    ),
                  ),
                ]),
              ],
            ),
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
                      "Add Photo",
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
    //String title,
    Key key,
    @required this.info,
  }) : super(key: key);

  final Info info;

  @override
  __InfoState createState() => __InfoState();
}

class __InfoState extends State<_Info> {
  __InfoState({
    String name,
  });
  //final db = Firestore.instance;
  //var document = Firestore.instance.collection('recipes').document('test');

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
    //dynamic title; //, type, user, ingredients, elaboration;

    // @override
    // void initState() {
    //   title = 'a';
    //   // type = 'a';
    //   // user = 'a';
    //   // ingredients = 'a';
    //   // elaboration = 'a';
    //   super.initState();
    // }

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
            (widget.info.title != null)
                ? Text(
                    widget.info.title,
                    style: TextStyle(
                      fontFamily: 'Bodoni',
                      fontWeight: FontWeight.w700,
                      fontSize: 42,
                      color: Color.fromARGB(255, 60, 22, 48),
                    ),
                  )
                : Text(
                    "There is no title",
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
                (widget.info.user != null)
                    ? _iconText(Icons.person, widget.info.user)
                    : _iconText(
                        Icons.person, 'There is no user'), //recipe.user),
                SizedBox(height: 20),
                (widget.info.type != null)
                    ? _iconText(Icons.local_dining, widget.info.type)
                    : _iconText(Icons.local_dining,
                        'There is no type'), //recipe.location),
                SizedBox(height: 20),
                (widget.info.time != null)
                    ? _iconText(Icons.calendar_today, widget.info.time)
                    : _iconText(Icons.calendar_today,
                        'There is no time'), //recipe.date),
                SizedBox(height: 35),

                Text(
                  "Ingredients",
                  style: TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(200, 86, 61, 94),
                      fontWeight: FontWeight.bold),
                ),
                Divider(thickness: 1),
                (widget.info.ingredients != null)
                    ? Text(
                        widget.info.ingredients, //recipe.description,
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(200, 86, 61, 94),
                        ),
                      )
                    : Text(
                        "There is no ingredients", //recipe.description,
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
                (widget.info.elaboration != null)
                    ? Text(
                        widget.info.elaboration, //recipe.description,
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(200, 86, 61, 94),
                        ),
                      )
                    : Text(
                        "There is no description", //recipe.description,
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
