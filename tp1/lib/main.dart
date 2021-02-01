import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

final favourites = Set<TitreAffichageModel>();
final titres = Set<TitreAffichageModel>();
final albums = Set<AlbumModel>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    artistes.forEach((artiste) {
      artiste.albums.forEach((album) {
        albums.add(album);
        album.titres.forEach((titre) {
          titres.add(new TitreAffichageModel(titre.titre, titre.duree,
              album.nom, album.urlPhoto, artiste.nom));
        });
      });
    });
    return MaterialApp(
      title: 'Mediathèque',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: NavBar(),
    );
  }
}

class TitresWidget extends StatefulWidget {
  @override
  _TitresWidgetState createState() => _TitresWidgetState();
}

class ArtisteWidget extends StatefulWidget {
  @override
  _ArtisteWidgetState createState() => _ArtisteWidgetState();
}

class FavouriteWidget extends StatefulWidget {
  @override
  _FavouriteWidgetState createState() => _FavouriteWidgetState();
}

class _FavouriteWidgetState extends State<FavouriteWidget> {
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
      itemCount: favourites.length *
          2, //a cause du diviseur qui prends tous les impairs
      itemBuilder: (BuildContext _context, int i) {
        if (i.isOdd) {
          return Divider();
        }
        final int index = i ~/ 2;

        return _buildRow(favourites.elementAt(index));
      },
    );
  }

  Widget _buildRow(TitreAffichageModel titre) {
    final alreadySaved = favourites.contains(titre);
    return ListTile(
      title: Text(
        titre.titre,
        style: _biggerFont,
      ),
      leading: Image.network(titre.urlPhoto),
      subtitle: Text("par " + titre.artiste + " ▫ " + titre.duree),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            favourites.remove(titre);
          } else {
            favourites.add(titre);
          }
        });
      },
    );
  }
}

class _TitresWidgetState extends State<TitresWidget> {
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
          titres.length * 2, //a cause du diviseur qui prends tous les impairs
      itemBuilder: (BuildContext _context, int i) {
        if (i.isOdd) {
          return Divider();
        }
        final int index = i ~/ 2;

        return _buildRow(titres.elementAt(index));
      },
    );
  }

  Widget _buildRow(TitreAffichageModel titre) {
    final alreadySaved = favourites.contains(titre);
    return ListTile(
      title: Text(
        titre.titre,
        style: _biggerFont,
      ),
      leading: Image.network(titre.urlPhoto),
      subtitle: Text("par " + titre.artiste + " ▫ " + titre.duree),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            favourites.remove(titre);
          } else {
            favourites.add(titre);
          }
        });
      },
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
      onTap: ,
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
    FavouriteWidget(),
    TitresWidget(),
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
            label: 'Titres',
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

class TitresModel {
  String titre;
  String duree;
  TitresModel({this.duree, this.titre});
}

class TitreAffichageModel extends TitresModel {
  String urlPhoto;
  String nomAlbum;
  String artiste;

  TitreAffichageModel(
      String titre, String duree, String album, String urlPhoto, String artiste)
      : super(duree: duree, titre: titre) {
    this.urlPhoto = urlPhoto;
    this.nomAlbum = album;
    this.artiste = artiste;
  }
}

class AlbumModel extends MediaModel {
  DateTime date;
  List<TitresModel> titres;

  AlbumModel(
      String nom, String urlPhoto, DateTime date, List<TitresModel> titres)
      : super(urlPhoto: urlPhoto, nom: nom) {
    this.date = date;
    this.titres = titres;
  }
}

class ArtisteModel extends MediaModel {
  String bio;
  List<AlbumModel> albums;

  ArtisteModel(String nom, String urlPhoto, String bio, List<AlbumModel> albums)
      : super(urlPhoto: urlPhoto, nom: nom) {
    this.bio = bio;
    this.albums = albums;
  }
}

class MediaModel {
  String nom;
  String urlPhoto;

  MediaModel({this.urlPhoto, this.nom});
}

final artistes = [
  new ArtisteModel(
      "Muse",
      "http://t0.gstatic.com/images?q=tbn:ANd9GcRAW298toQM6vNwq0o5QX642hqgOgVNyoXINl_nO4ZAoIiF8j2c",
      "Muse est un groupe de rock britannique, originaire de Teignmouth, dans le Devon, en Angleterre. Apparu sur la scène musicale en 1994, le trio est composé de Matthew Bellamy, Christopher Wolstenholme et Dominic Howard.",
      [
        new AlbumModel(
            "Origin of Symmetry",
            "https://images-na.ssl-images-amazon.com/images/I/81avaagb6-L._SL1417_.jpg",
            new DateTime(2001, 07, 17), [
          TitresModel(titre: "New Born", duree: "6:03"),
          TitresModel(titre: "Bliss", duree: "4:12"),
          TitresModel(titre: "Space Dementia", duree: "6:21"),
          TitresModel(titre: "Hyper Music", duree: "3:21"),
          TitresModel(titre: "Plug In Baby", duree: "3:39"),
          TitresModel(titre: "Citizen Erazed", duree: "7:19"),
          TitresModel(titre: "Microcuts", duree: "3:39"),
          TitresModel(titre: "Screenager", duree: "4:20"),
          TitresModel(titre: "Darkshines", duree: "4:47"),
          TitresModel(titre: "Feeling Good", duree: "3:19"),
          TitresModel(titre: "Megalomania", duree: "4:40"),
        ]),
        new AlbumModel(
            "Showbiz",
            "https://images-na.ssl-images-amazon.com/images/I/413vDD9Em6L._SY355_.jpg",
            new DateTime(1999, 09, 7), [
          TitresModel(titre: "Sunburn", duree: "3:55"),
          TitresModel(titre: "Muscle Museum", duree: "4:23")
        ])
      ]),
  new ArtisteModel(
      "My Chemical Romance",
      "https://cdn.wegow.com/media/artists/my-chemical-romance/my-chemical-romance-1504862605.59.2560x1440.jpg",
      "My Chemical Romance ou MCR est un groupe de rock alternatif américain, originaire du New Jersey. Actif depuis 2001, il est composé du chanteur Gerard Way, des guitaristes Ray Toro et Frank Iero, et du bassiste Mikey Way.",
      [
        new AlbumModel(
            "The Black Parade",
            "https://media.senscritique.com/media/000004867344/source_big/The_Black_Parade.jpg",
            new DateTime(2006, 10, 23), [
          TitresModel(titre: "Teenager", duree: "2:42"),
          TitresModel(titre: "Welcome to the Black Parade", duree: "5:11")
        ]),
        new AlbumModel(
            "Three Cheers for Sweet Revenge",
            "https://images-na.ssl-images-amazon.com/images/I/81vr2WI%2BqeL._SL1425_.jpg",
            new DateTime(2004, 06, 8), [
          TitresModel(
              titre: "I'm Not Okay (I Promise) [Explicit]", duree: "3:08"),
          TitresModel(titre: "Helena (So Long & Goodnight)", duree: "3:23")
        ])
      ]),
  new ArtisteModel(
      "AJR",
      "https://upload.wikimedia.org/wikipedia/commons/6/61/AJR_Group.jpg",
      "AJR est un trio pop indie américain composé des frères multi-instrumentistes Adam, Jack et Ryan Met. Le groupe écrit, produit et mixe leur matériel dans le salon de leur appartement à New York. Leurs singles les plus réussis incluent 'Weak' et 'Bang!'.",
      [
        new AlbumModel(
            "Neotheater",
            "https://images-na.ssl-images-amazon.com/images/I/81zKpNSNK1L._SL1500_.jpg",
            new DateTime(2019, 04, 26), [
          TitresModel(titre: "Next Up Forever", duree: "4:17"),
          TitresModel(titre: "Birthday Party", duree: "3:44")
        ]),
        new AlbumModel(
            "The Click",
            "https://upload.wikimedia.org/wikipedia/en/a/ae/AJR_The_Click.jpg",
            new DateTime(2017, 06, 9), [
          TitresModel(titre: "Sober Up", duree: "3:39"),
          TitresModel(titre: "Three-Thirty", duree: "3:30")
        ])
      ]),
  new ArtisteModel(
      "Arctic Monkeys",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZrGVsTLRFdqZ70smR-GE3Q2y5XrvPu-C4LQ&usqp=CAU&ec=45768318",
      "Arctic Monkeys est un groupe de rock britannique, originaire de Sheffield, South Yorkshire, en Angleterre. Il est formé en 2002, plus précisément à High Green, une banlieue de Sheffield. Le groupe est composé d'Alex Turner, de Jamie Cook, de Nick O'Malley, et de Matt Helders.",
      [
        new AlbumModel(
            "AM",
            "https://images-na.ssl-images-amazon.com/images/I/61yAkkPf51L._SL1500_.jpg",
            new DateTime(2013, 09, 9), [
          TitresModel(titre: "Do I Wanna Know?", duree: "4:32"),
          TitresModel(titre: "R U Mine?", duree: "3:21")
        ]),
        new AlbumModel(
            "Whatever People Say I Am, That's What I'm Not",
            "https://m.media-amazon.com/images/I/61-MakR51dL._SS500_.jpg",
            new DateTime(2017, 06, 9), [
          TitresModel(titre: "Mardy Bum", duree: "2:55"),
          TitresModel(
              titre: "I Bet You Look Good on the Dancefloor", duree: "2:54")
        ])
      ])
];
