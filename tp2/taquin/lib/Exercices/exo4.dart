import 'package:flutter/material.dart';
import 'package:taquin/Exercice.dart';

class Tile {
  String imageURL;
  Alignment alignment;

  Tile({this.imageURL, this.alignment});

  Widget croppedImageTile() {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: this.alignment,
            widthFactor: 0.3,
            heightFactor: 0.3,
            child: Image.network(this.imageURL),
          ),
        ),
      ),
    );
  }
}

// Tile tile = new Tile(
//     imageURL: ImageGenerator.getStaticImageURL(0), alignment: Alignment(0, 0));

class Exo4 extends Exercice {
  String title = "Exercice 4";
  String description = "Display a Tile as a Cropped Image";
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
          children: <Widget>[],
        ),
      ),
    );
  }
}
