import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

import 'customImage.dart';

// ignore: must_be_immutable
class EditorPage extends StatefulWidget {
  Future<File> imageFile;
  EditorPage({@required this.imageFile});
  @override
  EditorPageState createState() => EditorPageState();
}

class EditorPageState extends State<EditorPage>
    with SingleTickerProviderStateMixin {
  //Future<File> imageFile;

  /// Allows to control the editor and the document.
  ZefyrController _controller;
  TabController _tabController;
  String text;
  //StreamSubscription<NotusChange> _sub;
  // EditorPageState(this.imageFile);

  /// Zefyr editor like any other input field requires a focus node.
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    // Here we must load the document and pass it to Zefyr controller.
    final document = _loadDocument();
    _controller = ZefyrController(document);
    _tabController = TabController(length: 2, vsync: this);
    _focusNode = FocusNode();
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: widget.imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
            width: 150,
            height: 70,
          );
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
  Widget build(BuildContext context) {
    final TextStyle style = TextStyle(color: Colors.black);
    // Note that the editor requires special `ZefyrScaffold` widget to be
    // one of its parents.
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.black),
            title: Center(child: Text("Ajouter article", style: style)),
            backgroundColor: Colors.white,
            bottom: TabBar(controller: _tabController, tabs: [
              Tab(
                child: Text("Editer", style: style),
              ),
              Tab(
                child: Text("Preview", style: style),
              )
            ])),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(20),
                child: ZefyrScaffold(
                  child: ZefyrEditor(
                    padding: EdgeInsets.all(16),
                    controller: _controller,
                    focusNode: _focusNode,
                  ),
                )),
            Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    ZefyrView(
                      document: _controller.document,
                      imageDelegate: CustomImageDelegate(widget.imageFile),
                    ),
                    showImage(),
                  ],
                )),
          ],
        ));
  }

  /// Loads the document to be edited in Zefyr.
  NotusDocument _loadDocument() {
    // For simplicity we hardcode a simple document with one line of text
    // saying "Zefyr Quick Start".
    // (Note that delta must always end with newline.)
    final Delta delta = Delta()..insert("Text à ajouter\n");
    return NotusDocument.fromDelta(delta);
  }
}
