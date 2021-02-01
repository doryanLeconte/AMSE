import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: NavBar(),
    );
  }
}

class AlbumWidget extends StatefulWidget {
  @override
  _AlbumWidgetState createState() => _AlbumWidgetState();
}

class _AlbumWidgetState extends State<AlbumWidget> {
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildListView(),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount:
          albums.length * 2, //a cause du diviseur qui prends tous les impairs
      itemBuilder: (BuildContext _context, int i) {
        print(albums.length);
        if (i.isOdd) {
          return Divider();
        }
        final int index = i ~/ 2;

        return _buildRow(albums[index]);
      },
    );
  }

  Widget _buildRow(AlbumModel album) {
    return ListTile(
      title: Text(
        album.nom,
        style: _biggerFont,
      ),
      leading: Image.network(album.urlPhoto),
      subtitle: Text("par " +
          album.artiste +
          " le " +
          album.date.day.toString() +
          "/" +
          album.date.month.toString() +
          "/" +
          album.date.year.toString()),
      /* trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),*/
      /*    onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },*/
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class NavBar extends StatefulWidget {
  NavBar({Key key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Favoris',
      style: optionStyle,
    ),
    AlbumWidget(),
    Text(
      'Artistes',
      style: optionStyle,
    ),
    Text(
      'Infos',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mediathèque'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.album),
            label: 'Albums',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mic),
            label: 'Artistes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Infos',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class AlbumModel {
  String nom;
  String urlPhoto;
  DateTime date;
  String artiste;

  AlbumModel({this.nom, this.date, this.urlPhoto, this.artiste});
}

final albums = [
  AlbumModel(
      nom: "Origin of Symmetry",
      artiste: "Muse",
      date: new DateTime(2001, 07, 17),
      urlPhoto:
          "https://images-na.ssl-images-amazon.com/images/I/81avaagb6-L._SL1417_.jpg"),
  AlbumModel(
      nom: "The Black Parade",
      artiste: "My Chemical Romance",
      date: new DateTime(2006, 10, 23),
      urlPhoto:
          "https://media.senscritique.com/media/000004867344/source_big/The_Black_Parade.jpg"),
  AlbumModel(
      nom: "Neotheater",
      date: new DateTime(2019, 04, 26),
      urlPhoto:
          "https://images-na.ssl-images-amazon.com/images/I/81zKpNSNK1L._SL1500_.jpg",
      artiste: "AJR")
];
