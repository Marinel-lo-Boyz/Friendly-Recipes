import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);

    FirebaseAuth.instance.currentUser().then( (user) {
      user.providerId;
    });

    //  FirebaseAuth.instance.
  }

  Widget build(BuildContext context) {
    return Container();
  }
}
