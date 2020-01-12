import 'package:flutter/material.dart';

class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  List<String> expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems, String header, List<String> values) {
  return List.generate(numberOfItems, (int index) {
    return Item(
      headerValue: header,
      expandedValue: values,
    );
  });
}

class AddRecipePage extends StatefulWidget {
  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  List<Item> _dataType = generateItems(1, "Type", ["Starter","Main dish","Dessert"]);
  List<Item> _dataUsers = generateItems(1, "Users", ["Marc","Alejandro","Lluís"] );

  TextEditingController _titleCtrl,
      _typeCtrl,
      _userCtrl,
      _timeCtrl,
      _ingredientsCtrl,
      _elaborationCtrl;

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
                onTap: () => setState(() {item.headerValue = item.expandedValue[0]; _txtCtrl.text = item.expandedValue[0];}),
              ),
              ListTile(
                title: Text(item.expandedValue[1]),
                onTap: () => setState(() {item.headerValue = item.expandedValue[1]; _txtCtrl.text = item.expandedValue[1];}),
              ),
              ListTile(
                title: Text(item.expandedValue[2]),
                onTap: () => setState(() {item.headerValue = item.expandedValue[2]; _txtCtrl.text = item.expandedValue[2];} ),
              ),
            ],
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

  @override
  void initState() {
    _titleCtrl = TextEditingController();
    _typeCtrl = TextEditingController();
    _userCtrl = TextEditingController();
    _timeCtrl = TextEditingController();
    _ingredientsCtrl = TextEditingController();
    _elaborationCtrl = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Recipe'),
      ), //SingleChildScrollView
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _titleCtrl,
              decoration: InputDecoration(labelText: 'Recipe Name'),
            ),
            _buildPanel(_dataType, _typeCtrl),
            SizedBox(height: 10),
            _buildPanel(_dataUsers, _userCtrl),
            TextField(
              controller: _timeCtrl,
              decoration: InputDecoration(labelText: 'Time (ex: 12:45)'),
            ),
            TextField(
              controller: _ingredientsCtrl,
              decoration: InputDecoration(labelText: 'Ingredients'),
            ),
            TextField(
              controller: _elaborationCtrl,
              decoration: InputDecoration(labelText: 'Elaboration'),
            ),
            Spacer(),
            FlatButton(
              child: Text(
                'ADD',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.red,
              shape: StadiumBorder(),
              onPressed: () {
                Navigator.of(context).pop({
                  'title': _titleCtrl.text,
                  'type': _typeCtrl.text,
                  'user': _userCtrl.text,
                  'time': _timeCtrl.text,
                  'ingredients': _ingredientsCtrl.text,
                  'elaboration': _elaborationCtrl.text,
                });
              },
            )
          ],
        ),
      ),
    );
  }
}