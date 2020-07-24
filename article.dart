import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hello_world/validator.dart';
import 'package:hello_world/zefyr.dart';
import 'package:image_picker/image_picker.dart';
import 'constant.dart';
import 'fade.dart';
import 'custom_input_field.dart';
import 'interest_screen.dart';

/*void main() => runApp(
      new MaterialApp(
        home: new ResponsavelProfilePage(),
      ),
    );*/

class CompteForm extends StatefulWidget {
  //Animation<double> animation;

  CompteForm({Key key}) : super(key: key);
  @override
  @override
  _CompteFormState createState() => new _CompteFormState();
}

class _CompteFormState extends State<CompteForm>
    with SingleTickerProviderStateMixin {
  int count = 1;
  bool isClicked;
  TextEditingController controller;
  final _fullnameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AnimationController _animationController;
  Animation<double> _formElementAnimation;
  //final Animation<double> animation;
  var name = "";

  Future<File> imageFile;

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Stack(
            children: <Widget>[
              Container(
                  decoration: new BoxDecoration(color: Colors.white),
                  alignment: Alignment.center,
                  width: 400,
                  height: 120,
                  child: Image.file(
                    snapshot.data,
                    width: 300,
                    height: 300,
                  )),
              /*Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey[350],
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                        child: IconButton(
                          iconSize: 30,
                          onPressed: () {
                            setState(() {
                              isClicked = false;
                            });
                          },
                          icon: Icon(Icons.close),
                        ),
                      )))*/
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    print('delete image from List');
                    setState(() {
                      isClicked = false;
                    });
                  },
                  child: Icon(
                    Icons.close,
                  ),
                ),
              ),
            ],
          );
          /*return Container(
              child: Image.file(
            snapshot.data,
            width: 150,
            height: 70,
          ));*/
        } else if (snapshot.error != null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: "ecrire ici");
    isClicked = false;
    _animationController = AnimationController(
      vsync: this,
      duration: kLoginAnimationDuration,
    );

    var fadeSlideTween = Tween<double>(begin: 0.0, end: 1.0);

    _formElementAnimation = fadeSlideTween.animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.7,
        1.0,
        curve: Curves.easeInOut,
      ),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _fullnameController.dispose();
    controller.dispose();
    super.dispose();
  }

  // ignore: non_constant_identifier_names
  Widget ContactRow() {
    void _addNewContactRow() {
      setState(() {
        count = count + 1;
      });
    }

    return new Container(
        width: 170.0,
        padding: new EdgeInsets.all(5.0),
        child: new Column(children: <Widget>[
          Chip(
            onDeleted: () {
              setState(() {
                count = count - 1;
              });
            },
            deleteIcon: Icon(
              Icons.close,
              color: Colors.white,
              size: 20,
            ),
            backgroundColor: Colors.black,
            avatar: Container(
              width: 450,
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
                  onPressed: _addNewContactRow)),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? kSpaceM : kSpaceS;
    List<Widget> _contatos = new List.generate(count, (int i) => ContactRow());
    print(count);
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: new AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: new Center(
              child: new Text(
            "Ajouter article",
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.black,
            ),
          )),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: Form(
            key: _formKey,
            child: new LayoutBuilder(builder: (context, constraint) {
              return new Center(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    new Text(
                      "Nom de l'article",
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    FadeSlideTransition(
                        animation: _formElementAnimation,
                        additionalOffset: space,
                        child: CustomInputField(
                          label: 'Votre nom',
                          prefixIcon: Icons.person,
                          obscureText: false,
                          textController: _fullnameController,
                          validator: ValidatorService.fullNameValidate,
                          onChanged: (text) {
                            name = text;
                          },
                        )),
                    new Container(
                      padding: new EdgeInsets.all(30.0),
                    ),
                    new Text(
                      "Image de l'article",
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    FadeSlideTransition(
                      animation: _formElementAnimation,
                      additionalOffset: space,
                      child: isClicked
                          ? showImage()
                          : RaisedButton(
                              child: Text("Choisir l'image de l'article"),
                              onPressed: () {
                                setState(() {
                                  isClicked = true;
                                });
                                pickImageFromGallery(ImageSource.gallery);
                              },
                            ),
                    ),
                    new Container(
                      padding: new EdgeInsets.all(30.0),
                    ),
                    new Text(
                      "Expertises",
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    FadeSlideTransition(
                        animation: _formElementAnimation,
                        additionalOffset: space,
                        child: new Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(20, 20)),
                            border: Border.all(
                              width: 3,
                            ),
                          ),
                          height: 130.0,
                          width: 370.0,
                          child: new ListView(
                            children: _contatos,
                            scrollDirection: Axis.horizontal,
                          ),
                        )),
                    new Container(
                      padding: new EdgeInsets.all(55.0),
                    ),
                    new Container(
                        width: 350,
                        //color: Colors.blue,
                        //padding: new EdgeInsets.all(10.0),
                        child: Row(children: <Widget>[
                          Container(
                            width: 270,
                          ),
                          new Container(
                              width: 60,
                              color: Colors.black,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditorPage(imageFile: imageFile),
                                        ),
                                      );
                                    }
                                  }))
                        ])),
                  ],
                ),
              );
            })));
  }
}
