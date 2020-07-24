import 'package:flutter/material.dart';
import 'article.dart';
import 'articleList.dart';
import 'choice.dart';
import 'item.dart';
import 'my_icons_icons.dart';

/*void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Selectable GridView',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InterestsPage(),
    );
  }
}*/

// ignore: must_be_immutable
class InterestsPage extends StatefulWidget {
  final double screenHeight;
  String nom;
  String position;
  InterestsPage({
    Key key,
    this.screenHeight,
  }) : super(key: key);

  @override
  _InterestsPageState createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> {
  List<Choice> choices = [
    Choice(MyIcons.paint, "Art & culture"),
    Choice(MyIcons.ai, "Intelligence artificielle"),
    Choice(MyIcons.tractor_icon, "Agriculture"),
    Choice(MyIcons.recycle, "Environment"),
    Choice(MyIcons.college_graduation, "Education"),
    Choice(MyIcons.e, "E-commerce"),
    Choice(MyIcons.finance, "Finance"),
    Choice(MyIcons.food, "Restauration"),
    Choice(MyIcons.health_5fe9bcc602d060755a6375608845b192, "Santé"),
    Choice(MyIcons.cup, "Sport"),
    Choice(MyIcons.map, "Voyage"),
    Choice(MyIcons.projektmanagement, "Technologie"),
  ];

  @override
  Widget build(BuildContext context) {
    Widget gridViewSelection = GridView.count(
        //childAspectRatio: 2.0,
        padding: EdgeInsets.all(4.0),
        childAspectRatio: 9.0 / 10.0,
        crossAxisCount: 3,
        children: List.generate(choices.length, (index) {
          return Center(
            child: GridViewItem(choices[index]),
          );
        }));

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          title: new Center(
              child: Text("Préférences",
                  style: TextStyle(fontSize: 25, color: Colors.black))),
          backgroundColor: Colors.white,
        ),
        body: new LayoutBuilder(builder: (context, constraint) {
          return new Center(
            child: new Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                new Text(
                    "Veuillez séléctionnez les catégories qui vous interessent",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[700], fontSize: 17.0)),
                new Container(height: 570, child: gridViewSelection),
                new Container(
                  height: 10,
                ),
                Center(
                  child: RaisedButton.icon(
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CompteForm(),
                        ),
                      );
                    },
                    icon: Icon(Icons.arrow_forward, color: Colors.white),
                    label: Text(
                      "Poursuivre",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          );
        }));
  }
}
