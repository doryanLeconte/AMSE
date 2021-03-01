import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taquin/Exercice.dart';
import 'package:taquin/Exercices/Exo7/imagePicker.dart';
import 'package:taquin/Exercices/exo1.dart';
import 'package:taquin/Exercices/exo2.dart';
import 'package:taquin/Exercices/exo4.dart';
import 'package:taquin/Exercices/exo5.dart';
import 'package:taquin/Exercices/exo6.dart';

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
  void initState() {
    super.initState();
    exercices.add(new Exo1());
    exercices.add(new Exo2());
    exercices.add(new Exo4());
    exercices.add(new Exo5());
    exercices.add(new Exo6());
    exercices.add(new Exo7());
  }

  @override
  Widget build(BuildContext context) {
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
        trailing: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => exo));
          },
          icon: Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}
