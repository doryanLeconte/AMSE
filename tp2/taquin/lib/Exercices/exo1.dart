import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:taquin/Exercice.dart';

class Exo1 extends Exercice {
  String title = "Exercice 1";
  String description = "Display Image";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: title),
    );
  }

  @override
  String getDescription() {
    return description;
  }

  @override
  String getTitle() {
    return title;
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Transform.rotate(
                angle: Math.pi / -2,
                child: Image.network("https://picsum.photos/512/1024"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
