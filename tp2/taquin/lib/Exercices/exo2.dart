import 'dart:async';
import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:taquin/Exercice.dart';

class Exo2 extends Exercice {
  String title = "Exercice 2";
  String description = "Rotate & Scale Image + Animate";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercice 2',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Exercice 2'),
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
  double _currentRotateXValue = 0;
  double _currentRotateZValue = 0;
  double _currentScaleValue = 1;
  bool _currentCheckBoxValue = false;
  bool _playingAnimation = false;
  IconData playAnimationIcon = Icons.play_arrow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_playingAnimation) {
            setState(() {
              playAnimationIcon = Icons.play_arrow;
              _playingAnimation = false;
            });
          } else {
            setState(() {
              _playingAnimation = true;
              playAnimationIcon = Icons.pause;
            });
            const d = const Duration(microseconds: 50);
            new Timer.periodic(d, animate);
          }
        },
        child: Icon(playAnimationIcon),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(color: Colors.white),
              width: 400,
              height: 400,
              child: Transform(
                transform: Matrix4.rotationZ(_currentRotateZValue)
                  ..rotateX(_currentRotateXValue)
                  ..scale(_currentScaleValue)
                  ..rotateY(_currentCheckBoxValue ? 0 : Math.pi),
                alignment: Alignment.center,
                child: Image.network("https://picsum.photos/1024"),
              ),
            ),
            Container(
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(flex: 1, child: Text("Rotate X:")),
                  Expanded(
                    flex: 6,
                    child: Slider(
                        value: _currentRotateXValue,
                        max: Math.pi * 2,
                        min: 0,
                        onChanged: (double value) {
                          setState(() {
                            _currentRotateXValue = value;
                          });
                        }),
                  ),
                ],
              ),
            ),
            Container(
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(flex: 1, child: Text("Rotate Z:")),
                  Expanded(
                    flex: 6,
                    child: Slider(
                        value: _currentRotateZValue,
                        max: Math.pi * 2,
                        min: 0,
                        onChanged: (double value) {
                          setState(() {
                            _currentRotateZValue = value;
                          });
                        }),
                  ),
                ],
              ),
            ),
            Container(
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(flex: 1, child: Text("Mirror:")),
                  Expanded(
                    flex: 6,
                    child: Checkbox(
                      value: _currentCheckBoxValue,
                      onChanged: (value) {
                        setState(() {
                          _currentCheckBoxValue = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(flex: 1, child: Text("Scale:")),
                  Expanded(
                    flex: 6,
                    child: Slider(
                        value: _currentScaleValue,
                        max: 3,
                        min: 0,
                        onChanged: (double value) {
                          setState(() {
                            _currentScaleValue = value;
                          });
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void animate(Timer t) {
    double scaleValue = _currentScaleValue;
    double rotateXValue = _currentRotateXValue;
    double rotateZValue = _currentRotateZValue;
    scaleValue += 0.01;
    rotateXValue += Math.pi / 128;
    rotateZValue += Math.pi / 140;

    if (scaleValue > 3) scaleValue = 0;
    if (rotateXValue > Math.pi * 2) rotateXValue = 0;
    if (rotateZValue > Math.pi * 2) rotateZValue = 0;
    setState(() {
      _currentScaleValue = scaleValue;
      _currentRotateZValue = rotateZValue;
      _currentRotateXValue = rotateXValue;
    });
    if (!_playingAnimation) t.cancel();
  }
}
