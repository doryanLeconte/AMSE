import 'dart:math';

import 'package:flutter/material.dart';
import 'package:taquin/Exercice.dart';

class Exo5 extends Exercice {
  String title = "Exercice 5";
  String description = "Generate a tile board";
  @override
  Widget build(BuildContext context) {
    return MyHomePage(
      title: title,
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
  int _gridSize = 3;
  static const int MAX_SIZE = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Expanded(
                  child: GridView.builder(
                    itemCount: _gridSize * _gridSize,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _gridSize),
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    itemBuilder: (BuildContext _context, int i) {
                      return _buildContainer(i);
                    },
                  ),
                ),
              ),
              Container(
                width: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(flex: 1, child: Text("Size:")),
                    Expanded(
                      flex: 6,
                      child: Slider(
                        value: _gridSize.toDouble(),
                        max: MAX_SIZE.toDouble(),
                        min: 3,
                        label: _gridSize.toString(),
                        divisions: MAX_SIZE - 3,
                        onChanged: (double value) {
                          setState(() {
                            _gridSize = value.toInt();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }

  Widget _buildContainer(int tileNb) {
    return new Container(
      child: Text("Tile " + (tileNb + 1).toString()),
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      color: Colors.primaries[new Random().nextInt(Colors.primaries.length)],
    );
  }
}
