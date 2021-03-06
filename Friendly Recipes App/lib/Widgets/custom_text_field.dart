import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String myText;
  final IconData myIcon;
  final Function myOnChanged;
  final TextEditingController myController;
  CustomTextField(this.myText, this.myIcon, this.myOnChanged, {this.myController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 7.0, // has the effect of softening the shadow
                    spreadRadius: 3.0, // has the effect of extending the shadow
                    offset: Offset(0, 6.0),
                  )
                ],
              ),
              child: Container(
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: myController,
                  style: TextStyle(color: Colors.white),
                  onChanged: myOnChanged,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    hintText: myText,
                    hintStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(myIcon, color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
