import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:friendly_recipes_app/Pages/home_page.dart';
import 'package:friendly_recipes_app/Widgets/custom_text_field.dart';
import 'package:friendly_recipes_app/Widgets/shaded_container.dart';
import 'package:friendly_recipes_app/Widgets/shaded_flat_button.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final db = Firestore.instance;
  List<DocumentSnapshot> users;
  String userStr;
  String passwordStr;
  String currentError;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    userStr = '';
    passwordStr = '';
    currentError = '';
  }

  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: db.collection('users').orderBy('name').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          users = snapshot.data.documents;

          return Scaffold(
            resizeToAvoidBottomPadding: false,
            body: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(height: 200),
                      ShadedContainer(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image(
                              image: AssetImage('assets/icon.png'),
                              height: 50,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 22),
                      Center(
                        child: Text(
                          'Friendly Recipes',
                          style: TextStyle(
                              shadows: [
                                Shadow(
                                  blurRadius: 4,
                                  color: Colors.black26,
                                  offset: Offset(0, 4),
                                )
                              ],
                              fontFamily: 'Berlin Sans',
                              fontWeight: FontWeight.w900,
                              fontSize: 36,
                              color: Colors.black54),
                        ),
                      ),
                      SizedBox(height: 22),
                      CustomTextField('User', Icons.person, (text) {
                        userStr = text;
                      }),
                      SizedBox(height: 22),
                      CustomTextField('Password', Icons.vpn_key, (text) {
                        passwordStr = text;
                      }),
                      SizedBox(height: 22),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ShadedFlatButton('Sing In', () => singIn()),
                          SizedBox(width: 22),
                          ShadedFlatButton('Log In', ()=> logIn()),
                        ],
                      ),
                      (currentError != '')
                          ? Text(currentError)
                          : Text(''),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  singIn() {
    if (userStr == '' || passwordStr == '') {
      setState(() {
        currentError = 'Not valid user or password';
      });

      return;
    }

    for (int index = 0; index < users.length; ++index) {
      if (users[index].data['name'] == userStr) {
        setState(() {
          currentError = 'User already exist. Try other user name';
        });

        return;
      }
    }

    db.collection('users').document().setData(
      {
        'name': userStr,
        'password': passwordStr,
      },
    );
  }

  logIn() {
    for (int index = 0; index < users.length; ++index) {
      if (users[index].data['name'] == userStr) {
        if (users[index].data['password'] == passwordStr) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) =>
                  HomePage(), //number that changesnumber that changes
            ),
          );
          return;
        } else {
          setState(() {
            currentError = 'Incorrect password. Try Again';
          });
          return;
        }
      }
    }

    setState(() {
      currentError = 'User not found. Try Again';
    });
  }
}
