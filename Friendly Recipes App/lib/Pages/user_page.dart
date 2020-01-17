import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:friendly_recipes_app/Widgets/custom_text_field.dart';
import 'package:friendly_recipes_app/Widgets/shaded_container.dart';
import 'package:friendly_recipes_app/Widgets/shaded_flat_button.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          ListView(
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
                  CustomTextField('User', Icons.person, (text) {}),
                  SizedBox(height: 22),
                  CustomTextField('Password', Icons.vpn_key, (text) {}),
                  SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ShadedFlatButton('Sing In', () {}),
                      SizedBox(width: 22),
                      ShadedFlatButton('Log In', () {}),
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
// }

//           MediaQuery.removePadding(
//             context: context,
//             removeTop: true,
//             child: ListView(
//               padding: EdgeInsets.only(right: 35, left: 35, top: 20),
//               children: <Widget>[
//                 SizedBox(height: 130),
//                 buildWeeklyRecipeSection(),
//                 SizedBox(height: 22),
//                 buildFilters(),
//                 SizedBox(height: 22),
//                 buildRecipesList(),
//                 SizedBox(height: 100),
//               ],
//             ),
//           )
