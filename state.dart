import 'package:flutter/material.dart';

void main() => runApp(
      new MaterialApp(
        home: new ResponsavelProfilePage(),
      ),
    );

class ResponsavelProfilePage extends StatefulWidget {
  @override
  _ResponsavelProfilePageState createState() =>
      new _ResponsavelProfilePageState();
}

class _ResponsavelProfilePageState extends State<ResponsavelProfilePage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> _contatos =
        new List.generate(ContactRow.count, (int i) => new ContactRow());

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("NonstopIO"),
        ),
        body: new LayoutBuilder(builder: (context, constraint) {
          return new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new TextFormField(
                  decoration: new InputDecoration(
                    labelText: 'Nome',
                  ),
                ),
                new Container(
                  padding: new EdgeInsets.all(20.0),
                ),
                new TextFormField(
                  decoration: new InputDecoration(
                    labelText: 'Data de nascimento',
                  ),
                ),
                new Container(
                  padding: new EdgeInsets.all(20.0),
                ),
                new Container(
                  height: 200.0,
                  child: new ListView(
                    children: _contatos,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                new FlatButton(
                  onPressed: null,
                  child: new Icon(Icons.add),
                ),
                //new ContactRow()
              ],
            ),
          );
        }));
  }
}

class ContactRow extends StatefulWidget {
  static int count = 1;
  static bool isClicked = false;
  @override
  State<StatefulWidget> createState() => new _ContactRow();
}

class _ContactRow extends State<ContactRow> {
  bool isClicked;
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: "ecrire ici");
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: 170.0,
        padding: new EdgeInsets.all(5.0),
        child: new Column(children: <Widget>[
          Chip(
            onDeleted: () {
              setState(() {
                ContactRow.count = ContactRow.count - 1;
              });
            },
            deleteIcon: isClicked
                ? Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20,
                  )
                : null,
            backgroundColor: Colors.black,
            avatar: isClicked
                ? null
                : Container(
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: _addNewContactRow,
                    ),
                  ),
            label: EditableText(
              controller: controller,
              focusNode: FocusNode(),
              backgroundCursorColor: Colors.white,
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
            ),
          ),
          new Container(
              //padding: new EdgeInsets.all(10.0),
              child: IconButton(
                  alignment: Alignment.topCenter,
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed:
                      _addNewContactRow) /*RaisedButton(
                  child: Icon(Icons.add), onPressed: _addNewContactRow)*/
              ),
        ]));
  }

  void _addNewContactRow() {
    setState(() {
      ContactRow.count = ContactRow.count + 1;
      isClicked = true;
    });
  }
}
