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

class ArtisteWidget extends StatefulWidget {
  @override
  _ArtisteWidgetState createState() => _ArtisteWidgetState();
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

class _ArtisteWidgetState extends State<ArtisteWidget> {
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
          artistes.length * 2, //a cause du diviseur qui prends tous les impairs
      itemBuilder: (BuildContext _context, int i) {
        if (i.isOdd) {
          return Divider();
        }
        final int index = i ~/ 2;

        return _buildRow(artistes[index]);
      },
    );
  }

  Widget _buildRow(ArtisteModel artiste) {
    return ListTile(
      title: Text(
        artiste.nom,
        style: _biggerFont,
      ),
      leading: Image.network(artiste.urlPhoto),
      subtitle: Text(artiste.bio),
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
    ArtisteWidget(),
    Text(
      'Développé par Doryan Leconte & Fatima Maslouhi',
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

class ArtisteModel {
  String nom;
  String urlPhoto;
  String bio;

  ArtisteModel({this.nom, this.bio, this.urlPhoto});
}

final artistes = [
  ArtisteModel(
      nom: "Muse",
      urlPhoto:
          "http://t0.gstatic.com/images?q=tbn:ANd9GcRAW298toQM6vNwq0o5QX642hqgOgVNyoXINl_nO4ZAoIiF8j2c",
      bio:
          "Muse est un groupe de rock britannique, originaire de Teignmouth, dans le Devon, en Angleterre. Apparu sur la scène musicale en 1994, le trio est composé de Matthew Bellamy, Christopher Wolstenholme et Dominic Howard."),
  ArtisteModel(
      nom: "My Chemical Romance",
      bio:
          "My Chemical Romance ou MCR est un groupe de rock alternatif américain, originaire du New Jersey. Actif depuis 2001, il est composé du chanteur Gerard Way, des guitaristes Ray Toro et Frank Iero, et du bassiste Mikey Way.",
      urlPhoto:
          "https://cdn.wegow.com/media/artists/my-chemical-romance/my-chemical-romance-1504862605.59.2560x1440.jpg"),
  ArtisteModel(
      nom: "AJR",
      bio:
          "AJR est un trio pop indie américain composé des frères multi-instrumentistes Adam, Jack et Ryan Met. Le groupe écrit, produit et mixe leur matériel dans le salon de leur appartement à New York. Leurs singles les plus réussis incluent 'Weak' et 'Bang!'.",
      urlPhoto:
          "https://upload.wikimedia.org/wikipedia/commons/6/61/AJR_Group.jpg"),
  ArtisteModel(
      nom: "Arctic Monkeys",
      bio:
          "Arctic Monkeys est un groupe de rock britannique, originaire de Sheffield, South Yorkshire, en Angleterre. Il est formé en 2002, plus précisément à High Green, une banlieue de Sheffield. Le groupe est composé d'Alex Turner, de Jamie Cook, de Nick O'Malley, et de Matt Helders.",
      urlPhoto:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZrGVsTLRFdqZ70smR-GE3Q2y5XrvPu-C4LQ&usqp=CAU&ec=45768318")
];

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
      artiste: "AJR"),
  AlbumModel(
      nom: "Whatever People Say I Am, That's What I'm Not",
      date: new DateTime(2006, 01, 23),
      artiste: "Arctic Monkeys",
      urlPhoto: "https://m.media-amazon.com/images/I/61-MakR51dL._SS500_.jpg")
];
