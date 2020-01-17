import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmallFeatureText extends StatelessWidget {
  final String text;
  final IconData icon;
  const SmallFeatureText(this.text, this.icon);
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.end,
      text: TextSpan(
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Icon(
              this.icon,
              size: 14,
              color: Colors.black26,
            ),
          ),
          TextSpan(
            style: TextStyle(color: Colors.black26),
            text: "  " + this.text,
          ),
        ],
      ),
    );
  }
}
