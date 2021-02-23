import 'dart:math';

import 'package:flutter/material.dart';
import 'package:taquin/Exercice.dart';

import '../../util.dart';

Random random = new Random();

class Exo7 extends Exercice {
  String title = "Exercice 7";
  String description = "Jeu de Taquin";
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

class Tile {
  Color color;
  int tileNb;
  String text = "Tile ";
  bool touchable = false;
  bool touched = false;
  bool isWhite = false;
  String imageURL;
  Alignment alignment;

  Tile(this.color, this.tileNb, this.text, this.imageURL, this.alignment);

  Tile.randomColor() {
    this.color = Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }

  Tile.color(int index) {
    this.color = Colors.blueGrey;
    this.tileNb = index;
  }

  Tile.image(int index, String imageURL) {
    this.imageURL = imageURL;
    this.tileNb = index;
    alignment = Alignment(0, 0);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _gridSize = 4;
  bool sizeChanged = true;
  bool shuffled = false;
  int selectedShuffle;
  int shuffleCount;
  int BABY_SHUFFLE = 10;
  int SOFT_SHUFFLE;
  int MEDIUM_SHUFFLE;
  int HARD_SHUFFLE;
  static const int MAX_SIZE = 10;

  List<TileWidget> adjacentTiles;
  bool started = false;

  List<Widget> tiles;
  @override
  void initState() {
    SOFT_SHUFFLE = _gridSize * _gridSize;
    MEDIUM_SHUFFLE = SOFT_SHUFFLE * 2;
    HARD_SHUFFLE = MEDIUM_SHUFFLE * 2;
    shuffleCount = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (sizeChanged) {
      tiles = [];
      for (var i = 0; i < _gridSize * _gridSize; i++) {
        tiles.add(TileWidget(
            Tile.image(i, ImageGenerator.getStaticImageURL(IMAGE_SIZE)),
            this._gridSize));
      }
      if (started) {
        int randomTileNb = random.nextInt(tiles.length);
        TileWidget t = tiles[randomTileNb];
        t.tile.isWhite = true;
        sizeChanged = false;
      }
    }
    if (started) {
      adjacentTiles = getAdjacentTiles();
      if (!shuffled) {
        int selectedShuffle = HARD_SHUFFLE;

        for (int i = 0; i < selectedShuffle; i++) {
          adjacentTiles = getAdjacentTiles();
          TileWidget selectedTile =
              adjacentTiles[random.nextInt(adjacentTiles.length)];
          selectedTile.tile.touched = true;
          print(selectedTile.tile.tileNb);
          swapTiles(selectedTile);
          adjacentTiles = getAdjacentTiles();
        }

        setState(() {
          shuffled = true;
        });
      }
    }
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
              started
                  ? new Container(width: 0, height: 0)
                  : Row(
                      children: [
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
                                      sizeChanged = true;
                                      _gridSize = value.toInt();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              started = true;
                            });
                          },
                          child: Icon(Icons.play_arrow),
                        ),
                      ],
                    )
            ]),
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

  int getWhiteTileIndex() {
    int whiteTileIndex;
    int index = 0;
    tiles.forEach((element) {
      TileWidget t = element;
      if (t.tile.isWhite) whiteTileIndex = index;
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
        child: tile.croppedImageTile(_gridSize.toDouble()),
        onTap: () {
          setState(() {
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
                : Image.network(this.tile.imageURL),
          ),
        ),
      ),
    );
  }
}
