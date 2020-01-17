import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShadedContainer extends StatelessWidget {
  final Widget child;
  final BorderRadius borderRadius;
  const ShadedContainer( {@required this.child, @required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: this.borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius:  20, // has the effect of softening the shadow
            spreadRadius: 4, // has the effect of extending the shadow
            offset: Offset(0, 8),
          )
        ],
      ),
      child: this.child,
    );
  }
}
