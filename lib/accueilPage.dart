import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AccueilPage extends StatefulWidget {
  // Ajoutez un constructeur avec une clé
  AccueilPage({Key? key}) : super(key: key); // Assurez-vous d'ajouter un constructeur avec un paramètre 'key'.

  @override
  _AccueilPageState createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Mettre à jour avec le nouvel index
    });
  }
  @override
  Widget build(BuildContext context) {
    // Votre UI sera construit ici
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenue !'),
        backgroundColor: Color(0xFF15232E),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Ajoutez des sections pour les séries populaires et les comics ici
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF0F1E2B), // Arrière-plan bottom bar
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
        selectedItemColor: Color(0xFF12273C), // Texte bottom bar - sélectionné
        unselectedItemColor: Color(0xFF778BA8), // Texte bottom bar - non sélectionné
        selectedLabelStyle: TextStyle(color: Color(0xFF12273C)), // Style pour le label sélectionné
        unselectedLabelStyle: TextStyle(color: Color(0xFF778BA8)), // Style pour le label non sélectionné
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
            icon: SvgPicture.asset('assets/images/navbar_series.svg', color: _selectedIndex == 2 ? Colors.blue : Colors.grey),
            label: 'Séries',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/navbar_movies.svg', color: _selectedIndex == 3 ? Colors.blue : Colors.grey),
            label: 'Films',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/navbar_search.svg', color: _selectedIndex == 4 ? Colors.blue : Colors.grey),
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
