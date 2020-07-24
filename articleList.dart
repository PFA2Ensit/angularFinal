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
  int _count = 1;
  List<String> chips = List();
  TextEditingController controller = TextEditingController(text: "ecrire ici");

  @override
  Widget build(BuildContext context) {
    List<Widget> _contatos =
        new List.generate(_count, (int i) => new ContactRow());

    return new Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: new AppBar(
          title: new Text("NonstopIO"),
        ),
        body: new LayoutBuilder(builder: (context, constraint) {
          final _maxHeight = constraint.biggest.height / 3;
          final _biggerFont = TextStyle(fontSize: _maxHeight / 6);

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
                  onPressed: _addNewContactRow,
                  child: new Icon(Icons.add),
                ),
                //new ContactRow()
              ],
            ),
          );
        }));
  }

  void _addNewContactRow() {
    setState(() {
      _count = _count + 1;
      /*chips.add(controller.text);
      print(chips.toString());*/
    });
  }
}

class ContactRow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ContactRow();
}

class _ContactRow extends State<ContactRow> {
  TextEditingController controller = TextEditingController(text: "ecrire ici");
  List<String> chips = List();
  bool selected = false;
  bool isEditable = false;

  String initialText = "Initial Text";

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: 150.0,
        padding: new EdgeInsets.all(5.0),
        child: new Column(children: <Widget>[
          InputChip(
            onPressed: () {
              setState(() {});
            },
            onDeleted: () {
              setState(() {
                //count = count - 1;
              });
            },
            deleteIcon: Icon(
              Icons.close,
              color: Colors.white,
              size: 20,
            ),
            backgroundColor: Colors.black,
            avatar: Container(
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
                onPressed: null,
              ),
            ),
            label: EditableText(
              autofocus: true,
              onSubmitted: (value) {
                chips.add(value);

                print(chips.toList());
                setState(() {
                  chips = chips;
                });
              },
              controller: controller,
              focusNode: FocusNode(),
              backgroundCursorColor: Colors.white,
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
            ),
          ),
          new Container(
              child: IconButton(
                  alignment: Alignment.topCenter,
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: null)),
        ]));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

/*class ChipsField extends StatefulWidget {
  @override
  _ChipsFieldState createState() => new _ChipsFieldState();
}

class _ChipsFieldState extends State<ChipsField> {
  int count = 1;
  bool isClicked;
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: "ecrire ici");
    isClicked = false;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // ignore: non_constant_identifier_names
  Widget ContactRow() {
    void _addNewContactRow() {
      setState(() {
        //isClicked = true;
        count = count + 1;
        isClicked = false;
      });
    }

    return new Container(
        width: 150.0,
        padding: new EdgeInsets.all(5.0),
        child: new Column(children: <Widget>[
          Chip(
            onDeleted: () {
              setState(() {
                count = count - 1;
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

  @override
  Widget build(BuildContext context) {
    List<Widget> _chips = new List.generate(count, (int i) => ContactRow());
    print(count);
    return new Scaffold(body: new LayoutBuilder(builder: (context, constraint) {
      return new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              padding: new EdgeInsets.all(20.0),
            ),
            new Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
                border: Border.all(
                  width: 3,
                ),
              ),
              height: 130.0,
              width: 350.0,
              child: new ListView(
                children: _chips,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      );
    }));
  }
}
*/
