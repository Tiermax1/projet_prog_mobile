import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AccueilPage extends StatefulWidget {
  // Ajoutez un constructeur avec une clé
  AccueilPage({Key? key}) : super(key: key); // Assurez-vous d'ajouter un constructeur avec un paramètre 'key'.

  @override
  _AccueilPageState createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  @override
  int _selectedIndex = 0; // Initialisation à 0 pour sélectionner le premier onglet
  Widget build(BuildContext context) {
    // Votre UI sera construit ici
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenue !'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Ajoutez des sections pour les séries populaires et les comics ici
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/navbar_home.svg', color: _selectedIndex == 0 ? Colors.blue : Colors.grey),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/navbar_comics.svg', color: _selectedIndex == 1 ? Colors.blue : Colors.grey),
            label: 'Comics',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/navbar_series.svg', color: _selectedIndex == 1 ? Colors.blue : Colors.grey),
            label: 'Séries',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/navbar_movies.svg', color: _selectedIndex == 1 ? Colors.blue : Colors.grey),
            label: 'Films',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/navbar_search.svg', color: _selectedIndex == 1 ? Colors.blue : Colors.grey),
            label: 'Recherche',
          ),
          // Vous pouvez ajouter plus d'items ici
        ],
      ),

    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AccueilPage(),
  ));
}
