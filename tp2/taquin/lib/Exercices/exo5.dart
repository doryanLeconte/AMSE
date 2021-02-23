import 'package:flutter/material.dart';
import 'package:taquin/Exercice.dart';

import '../util.dart';


class Tile {
  String imageURL;
  Alignment alignment;

  Tile({this.imageURL, this.alignment});

  Widget croppedImageTile(double gridSize, int tileNb) {
    double yPos =
        ((tileNb / (gridSize)).truncate().toDouble() / ((gridSize - 1) / 2) -
            1);
    double xPos = ((tileNb % gridSize) / ((gridSize - 1) / 2)) - 1;
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: Alignment(xPos, yPos),
            widthFactor: 1 / gridSize,
            heightFactor: 1 / gridSize,
            child: Image.network(this.imageURL),
          ),
        ),
      ),
    );
  }
}

Tile tile = new Tile(
  imageURL: ImageGenerator.getStaticImageURL(IMAGE_SIZE),
  alignment: Alignment(0, 0),
);

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
  static const int MAX_GRID_SIZE = 10;

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
                        max: MAX_GRID_SIZE.toDouble(),
                        min: 3,
                        label: _gridSize.toString(),
                        divisions: MAX_GRID_SIZE - 3,
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

  Widget createTileWidgetFrom(Tile tile, int tileNb) {
    return InkWell(
      child: tile.croppedImageTile(_gridSize.toDouble(), tileNb),
      onTap: () {
        print("tapped on tile");
      },
    );
  }

  Widget _buildContainer(int tileNb) {
    return new Container(
      child: createTileWidgetFrom(tile, tileNb),
      padding: const EdgeInsets.all(2),
    );
  }
}
