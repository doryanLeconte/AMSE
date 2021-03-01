import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taquin/Exercice.dart';
import 'package:taquin/Exercices/Exo7/exo7.dart';

class Exo7 extends Exercice {
  String title = "Exercice 7";
  String description = "Jeu de Taquin";
  @override
  Widget build(BuildContext context) {
    return imagePicker(
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

class imagePicker extends StatefulWidget {
  imagePicker({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _imagePickerState createState() => _imagePickerState();
}

class _imagePickerState extends State<imagePicker> {
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
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Card(
            child: ListTile(
              title: Center(
                child: Text(
                  "Choose a picture",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("From the library"),
              leading: Icon(Icons.image),
              trailing: Icon(Icons.play_arrow),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<Image>(
                      builder: (context) => imageSelector()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Random from the internet"),
              leading: Icon(Icons.web),
              trailing: Icon(Icons.play_arrow),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<Image>(
                      builder: (context) => new Taquin(
                            new Image.network(
                              "https://picsum.photos/1024",
                              key: ValueKey(new Random().nextInt(100)),
                            ),
                          )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class imageSelectorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {}
}

class imageSelector extends StatefulWidget {
  @override
  _imageSelectorState createState() => _imageSelectorState();
}

class _imageSelectorState extends State<imageSelector> {
  List<String> imagePaths = [];

  @override
  Widget build(BuildContext context) {
    _initImages();
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose a picture"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: imagePaths.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: InkWell(
              child: new GridTile(
                  child: Image(image: AssetImage(imagePaths[index]))),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<Image>(
                      builder: (context) => new Taquin(
                          Image(image: AssetImage(imagePaths[index])))),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future _initImages() async {
    // >> To get paths you need these 2 lines
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths =
        manifestMap.keys.where((String key) => key.contains('.jpg')).toList();

    setState(() {
      this.imagePaths = imagePaths;
    });
  }

  gridBuilder() {}
}
