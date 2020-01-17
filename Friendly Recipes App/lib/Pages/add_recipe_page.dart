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

List<Item> generateItems(
    int numberOfItems, String header, List<String> values) {
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
  List<Item> _dataType =
      generateItems(1, "Type", ["Starter", "Main dish", "Dessert"]);

  TextEditingController _nameCtrl,
      _typeCtrl,
      _ingredientsCtrl,
      _elaborationCtrl;

  TextStyle titleStyle = TextStyle(
    fontFamily: 'Berlin Sans',
    color: Colors.orange,
    fontWeight: FontWeight.bold,
    fontSize: 22,
  );

  TextStyle textStyle = TextStyle(
    fontFamily: 'Berlin Sans',
    color: Colors.black45,
  );

    TextStyle textStyle2 = TextStyle(
    fontFamily: 'Berlin Sans',
    color: Colors.black38,
  );

  @override
  void initState() {
    _nameCtrl = TextEditingController();
    _typeCtrl = TextEditingController();
    _ingredientsCtrl = TextEditingController();
    _elaborationCtrl = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 40),
        children: <Widget>[
          Text(
            'Type',
            style: titleStyle,
          ),
          SizedBox(height: 6),
          _buildPanel(_dataType, _typeCtrl),
          SizedBox(height: 20),
          Text(
            'Recipe Name',
            style: titleStyle,
          ),
          SizedBox(height: 4),
          buildCustomTextField('Name', _nameCtrl),
          SizedBox(height: 20),
          Text(
            'Ingredients',
            style: titleStyle,
          ),
          SizedBox(height: 4),
          buildCustomTextField('Ingredients', _ingredientsCtrl),
          SizedBox(height: 20),
          Text(
            'Elaboration',
            style: titleStyle,
          ),
          SizedBox(height: 4),
          buildCustomTextField('Elaboration', _elaborationCtrl),
          SizedBox(height: 20),
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
                'title': _nameCtrl.text,
                'type': _typeCtrl.text,
                'user': 'xXLluis99Xx',
                'time': 'Monday',
                'ingredients': _ingredientsCtrl.text,
                'elaboration': _elaborationCtrl.text,
              });
            },
          )
        ],
      ),
    );
  }

  Widget buildCustomTextField(String text, TextEditingController controller) {
    BorderRadius radiusTile = BorderRadius.circular(20);

    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: radiusTile,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20.0, // has the effect of softening the shadow
                  spreadRadius: 4.0, // has the effect of extending the shadow
                  offset: Offset(0, 10.0),
                )
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: radiusTile,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
                child: TextField(
                  style: textStyle,
                  maxLines: null,
                  minLines: 3,
                  controller: controller,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    hintText: text,
                    hintStyle: TextStyle(color: Colors.black26),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
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
              title: Text(
                item.headerValue,
                style: textStyle,
              ),
            );
          },
          body: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  item.expandedValue[0],
                  style: textStyle2,
                ),
                onTap: () => setState(() {
                  item.headerValue = item.expandedValue[0];
                  _txtCtrl.text = item.expandedValue[0];
                }),
              ),
              ListTile(
                title: Text(
                  item.expandedValue[1],
                  style: textStyle2,
                ),
                onTap: () => setState(() {
                  item.headerValue = item.expandedValue[1];
                  _txtCtrl.text = item.expandedValue[1];
                }),
              ),
              ListTile(
                title: Text(
                  item.expandedValue[2],
                  style: textStyle2,
                ),
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
}
