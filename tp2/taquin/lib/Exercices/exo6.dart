import 'dart:math';

import 'package:flutter/material.dart';
import 'package:taquin/Exercice.dart';

Random random = new Random();

class Exo6 extends Exercice {
  String title = "Exercice 6";
  String description = "Moving Tiles";
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
  static const defaultGridSize = 4;
  int _gridSize = defaultGridSize;
  static const int MAX_SIZE = 10;
  TileWidget whiteTile;

  List<Widget> tiles = List<Widget>.generate(defaultGridSize * defaultGridSize,
      (index) => TileWidget(Tile.color(index)));

  @override
  void initState() {
    whiteTile = tiles[random.nextInt(tiles.length)];
    whiteTile.tile.color = Colors.white;
    whiteTile.tile.text = "Empty ";

    List<TileWidget> adjacentTiles = [];

    if (whiteTile.tile.tileNb % _gridSize != 0)
      adjacentTiles.add(tiles[whiteTile.tile.tileNb - 1]);
    if (whiteTile.tile.tileNb % _gridSize != _gridSize - 1)
      adjacentTiles.add(tiles[whiteTile.tile.tileNb + 1]);
    if (whiteTile.tile.tileNb + _gridSize < tiles.length)
      adjacentTiles.add(tiles[whiteTile.tile.tileNb + _gridSize]);
    if (whiteTile.tile.tileNb - _gridSize >= 0)
      adjacentTiles.add(tiles[whiteTile.tile.tileNb - _gridSize]);

    adjacentTiles.forEach((element) {
      element.tile.touchable = true;
    });

    super.initState();
  }

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
                      return _buildContainer(tiles[i]);
                    },
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  Widget _buildContainer(TileWidget tile) {
    return tile.textBox();
  }
}

class Tile {
  Color color;
  int tileNb;
  String text = "Tile ";
  bool touchable = false;

  Tile(this.color, this.tileNb, this.text);

  Tile.randomColor() {
    this.color = Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }

  Tile.color(int index) {
    this.color = Colors.blueGrey;
    this.tileNb = index;
  }
}

class TileWidget extends StatelessWidget {
  final Tile tile;

  TileWidget(this.tile);

  @override
  Widget build(BuildContext context) {
    return this.textBox();
  }

  Widget coloredBox() {
    return Container(
        color: tile.color,
        child: Padding(
          padding: EdgeInsets.all(70.0),
        ));
  }

  Widget textBox() {
    return InkWell(
      child: Container(
        child: Text(tile.text + (tile.tileNb + 1).toString()),
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: tile.touchable
              ? Border(
                  top: BorderSide(width: 1.0, color: Colors.red),
                  left: BorderSide(width: 1.0, color: Colors.red),
                  right: BorderSide(width: 1.0, color: Colors.red),
                  bottom: BorderSide(width: 1.0, color: Colors.red),
                )
              : null,
          color: tile.color,
        ),
      ),
      onTap: () {},
    );
  }
}
