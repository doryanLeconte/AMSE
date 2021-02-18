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
  List<TileWidget> adjacentTiles;

  List<Widget> tiles = List<Widget>.generate(defaultGridSize * defaultGridSize,
      (index) => TileWidget(Tile.color(index)));

  @override
  void initState() {
    whiteTile = tiles[random.nextInt(tiles.length)];
    whiteTile.tile.color = Colors.white;
    whiteTile.tile.text = "Empty ";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    adjacentTiles = [];

    int whiteTileIndex = getWhiteTileIndex();

    if (whiteTileIndex % _gridSize != 0)
      adjacentTiles.add(tiles[whiteTileIndex - 1]);
    if (whiteTileIndex % _gridSize != _gridSize - 1)
      adjacentTiles.add(tiles[whiteTileIndex + 1]);
    if (whiteTileIndex + _gridSize < tiles.length)
      adjacentTiles.add(tiles[whiteTileIndex + _gridSize]);
    if (whiteTileIndex - _gridSize >= 0)
      adjacentTiles.add(tiles[whiteTileIndex - _gridSize]);

    adjacentTiles.forEach((element) {
      element.tile.touchable = true;
    });

    // tiles.forEach((tile) {
    //   TileWidget t = tile;
    //   if (t.tile.touched) print(t.tile.tileNb);
    // });

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

  int getWhiteTileIndex() {
    int whiteTileIndex;
    int index = 0;
    tiles.forEach((element) {
      TileWidget t = element;
      if (t.tile.text.startsWith("Empty")) whiteTileIndex = index;
      index++;
    });
    return whiteTileIndex;
  }

  int getTouchedTileIndex() {
    int touchedTileIndex;
    int index = 0;
    tiles.forEach((element) {
      TileWidget t = element;
      if (t.tile.touched) touchedTileIndex = index;
      index++;
    });
    return touchedTileIndex;
  }

  Widget _buildContainer(TileWidget tile) {
    if (tile.tile.touchable)
      return InkWell(
        child: tile.textBox(),
        onTap: () {
          setState(() {
            tile.tile.touched = true;
            swapTiles(tile);
          });
        },
      );
    else
      return tile.textBox();
  }

  swapTiles(TileWidget touchedTile) {
    //print(touchedTile.tile.tileNb.toString());
    int whiteTileIndex = getWhiteTileIndex();
    int touchedTileIndex = getTouchedTileIndex();
    print("touched : " + touchedTileIndex.toString());
    print("white : " + whiteTileIndex.toString());

    adjacentTiles.forEach((element) {
      element.tile.touchable = false;
    });

    TileWidget removedWhiteTile = tiles.removeAt(whiteTileIndex);
    tiles.insert(whiteTileIndex, touchedTile);
    tiles.removeAt(touchedTileIndex);
    tiles.insert(touchedTileIndex, removedWhiteTile);

    touchedTile.tile.touched = false;
  }
}

class Tile {
  Color color;
  int tileNb;
  String text = "Tile ";
  bool touchable = false;
  bool touched = false;

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
    return Container(
      child: Text(tile.text + tile.tileNb.toString()),
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
    );
  }
}
