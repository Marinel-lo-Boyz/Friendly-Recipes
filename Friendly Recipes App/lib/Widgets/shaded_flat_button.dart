import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:friendly_recipes_app/Widgets/shaded_container.dart';

class ShadedFlatButton extends StatelessWidget {
  final String name;
  final Function myOnpressed;

  ShadedFlatButton(this.name, this.myOnpressed);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ShadedContainer(
              borderRadius: BorderRadius.circular(100),
              child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                color: Colors.white,
                shape: StadiumBorder(),
                child: Center(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Berlin Sans',
                      fontSize: 28,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                onPressed: myOnpressed,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
