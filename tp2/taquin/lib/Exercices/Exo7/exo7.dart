import 'dart:math';

import 'package:flutter/material.dart';

import '../../util.dart';

Random random = new Random();
Image gameImage;

class Taquin extends StatelessWidget {
  Taquin(Image image) {
    gameImage = image;
  }

  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Tile {
  Color color;
  int tileNb;
  String text = "Tile ";
  bool touchable = false;
  bool touched = false;
  bool isWhite = false;
  Image image;
  Alignment alignment;

  Tile(this.color, this.tileNb, this.text, this.alignment, this.image);

  Tile.randomColor() {
    this.color = Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }

  Tile.color(int index) {
    this.color = Colors.blueGrey;
    this.tileNb = index;
  }

  Tile.image(int index, Image image) {
    this.image = image;
    this.tileNb = index;
    alignment = Alignment(0, 0);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _gridSize = 4;
  bool sizeChanged = true;
  bool shuffled = false;
  int mouvementsCount = 0;
  int selectedShuffle;
  Map SHUFFLE_TYPES = new Map();
  int BABY_SHUFFLE = 10;
  int SOFT_SHUFFLE;
  int MEDIUM_SHUFFLE;
  int HARD_SHUFFLE;
  bool won = false;
  static const int MAX_SIZE = 10;

  List<TileWidget> adjacentTiles;
  bool started = false;

  List<TileWidget> tiles;
  @override
  void initState() {
    SOFT_SHUFFLE = _gridSize * _gridSize;
    MEDIUM_SHUFFLE = SOFT_SHUFFLE * 2;
    HARD_SHUFFLE = MEDIUM_SHUFFLE * 2;
    SHUFFLE_TYPES["Baby Shuffle"] = BABY_SHUFFLE;
    SHUFFLE_TYPES["Soft Shuffle"] = SOFT_SHUFFLE;
    SHUFFLE_TYPES["Medium Shuffle"] = MEDIUM_SHUFFLE;
    SHUFFLE_TYPES["Hard Shuffle"] = HARD_SHUFFLE;
    selectedShuffle = BABY_SHUFFLE;
    mouvementsCount = 0;
    won = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (sizeChanged) {
      tiles = [];
      for (var i = 0; i < _gridSize * _gridSize; i++) {
        tiles.add(TileWidget(Tile.image(i, gameImage), this._gridSize));
      }
    }
    if (started) {
      adjacentTiles = getAdjacentTiles();
      if (!shuffled) {
        for (int i = 0; i < selectedShuffle; i++) {
          adjacentTiles = getAdjacentTiles();
          TileWidget selectedTile =
              adjacentTiles[random.nextInt(adjacentTiles.length)];
          selectedTile.tile.touched = true;
          swapTiles(selectedTile);
          adjacentTiles = getAdjacentTiles();
        }

        setState(() {
          mouvementsCount = 0;
          shuffled = true;
        });
      } else {
        setState(() {
          won = isWon();
          if (won) {
            adjacentTiles.forEach((element) {
              element.tile.touchable = false;
            });
            adjacentTiles = [];
            tiles[getWhiteTileIndex()].tile.isWhite = false;
            shuffled = false;
            started = false;
          }
        });
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Taquin"),
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
                flex: 10,
                child: GridView.builder(
                  itemCount: _gridSize * _gridSize,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _gridSize,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1.0,
                  ),
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  itemBuilder: (BuildContext _context, int i) {
                    return _buildContainer(tiles[i]);
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text("Mouvements : " + mouvementsCount.toString()),
            ),
            Expanded(
              flex: 1,
              child: won ? Text("WINNER !") : Text(""),
            ),
            DropdownButton(
                value: selectedShuffle,
                onChanged: started
                    ? null
                    : (int newValue) {
                        setState(() {
                          selectedShuffle = newValue;
                        });
                      },
                items:
                    SHUFFLE_TYPES.entries.map<DropdownMenuItem<int>>((entry) {
                  return new DropdownMenuItem<int>(
                    value: entry.value,
                    child: Text(entry.key),
                  );
                }).toList()),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                RaisedButton(
                  child: Text("-"),
                  color: Colors.primaries.first,
                  onPressed: started || _gridSize <= 2
                      ? null
                      : () {
                          setState(() {
                            sizeChanged = true;
                            _gridSize--;
                          });
                        },
                ),
                FloatingActionButton(
                  child: started ? Icon(Icons.stop) : Icon(Icons.play_arrow),
                  onPressed: () {
                    setState(() {
                      started = !started;
                      shuffled = false;
                      won = false;
                      tiles[random.nextInt(tiles.length)].tile.isWhite = true;
                      sizeChanged = false;
                    });
                  },
                ),
                RaisedButton(
                  child: Text("+"),
                  color: Colors.primaries.first,
                  onPressed: started || _gridSize >= 10
                      ? null
                      : () {
                          setState(() {
                            sizeChanged = true;
                            _gridSize++;
                          });
                        },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<TileWidget> getAdjacentTiles() {
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

    return adjacentTiles;
  }

  bool isWon() {
    bool won = true;
    for (int i = 0; i < tiles.length && won; i++) {
      won = tiles[i].tile.tileNb == i;
    }
    return won;
  }

  int getWhiteTileIndex() {
    int whiteTileIndex;
    int index = 0;
    tiles.forEach((element) {
      if (element.tile.isWhite) whiteTileIndex = index;
      index++;
    });
    return whiteTileIndex;
  }

  int getTouchedTileIndex() {
    int touchedTileIndex;
    int index = 0;
    tiles.forEach((element) {
      if (element.tile.touched) touchedTileIndex = index;
      index++;
    });
    return touchedTileIndex;
  }

  Widget _buildContainer(TileWidget tile) {
    if (tile.tile.touchable)
      return InkWell(
        child: tile.croppedImageTile(_gridSize.toDouble()),
        onTap: () {
          setState(() {
            mouvementsCount++;
            tile.tile.touched = true;
            swapTiles(tile);
          });
        },
      );
    else
      return tile.taquinBox();
  }

  swapTiles(TileWidget touchedTile) {
    int whiteTileIndex = getWhiteTileIndex();
    int touchedTileIndex = getTouchedTileIndex();

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

class TileWidget extends StatelessWidget {
  final Tile tile;
  int gridSize;

  TileWidget(this.tile, this.gridSize);

  @override
  Widget build(BuildContext context) {
    return this.taquinBox();
  }

  Widget coloredBox() {
    return Container(
        color: tile.color,
        child: Padding(
          padding: EdgeInsets.all(70.0),
        ));
  }

  Widget taquinBox() {
    return Container(
      child: croppedImageTile(gridSize.toDouble()),
      // padding: const EdgeInsets.all(8),
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

  Widget croppedImageTile(double gridSize) {
    double yPos = ((tile.tileNb / (gridSize)).truncate().toDouble() /
            ((gridSize - 1) / 2) -
        1);
    double xPos = ((tile.tileNb % gridSize) / ((gridSize - 1) / 2)) - 1;
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: Alignment(xPos, yPos),
            widthFactor: 1 / gridSize,
            heightFactor: 1 / gridSize,
            child: tile.isWhite
                ? Container(
                    color: Colors.white,
                    height: IMAGE_SIZE.toDouble() / (gridSize * gridSize),
                    width: IMAGE_SIZE.toDouble() / (gridSize * gridSize),
                  )
                : this.tile.image,
          ),
        ),
      ),
    );
  }
}
