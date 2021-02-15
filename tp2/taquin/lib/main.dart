import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taquin/Exercice.dart';

import 'Exercices/exo1.dart';
import 'Exercices/exo2.dart';

void main() {
  runApp(Exo3());
}

class Exo3 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TP2',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'TP2'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Exercice exo1 = Exo1();
  List<Exercice> exercices = [];
  @override
  Widget build(BuildContext context) {
    exercices.add(new Exo1());
    exercices.add(new Exo2());

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: exercices.length,
        itemBuilder: (BuildContext _context, int i) {
          return _buildRow(exercices.elementAt(i));
        },
      ),
    );
  }

  Widget _buildRow(Exercice exo) {
    return new Card(
      child: ListTile(
        title: Text(exo.getTitle()),
        subtitle: Text(exo.getDescription()),
        trailing: FlatButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => exo));
          },
          child: Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}
