import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    CollectionReference reference = Firestore.instance.collection('recipes');
reference.snapshots().listen((querySnapshot) {
    setState(() {
      
    });
});
  }

  @override
  Widget build(BuildContext context) {
    final db = Firestore.instance;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('recipes').orderBy('name').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<DocumentSnapshot> groups = snapshot.data.documents;
          return ListView.builder(
            itemCount: groups.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('BANG');
                },
                child: ListTile(
                  title: Text(
                    groups[index].data['name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(groups[index].documentID),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
