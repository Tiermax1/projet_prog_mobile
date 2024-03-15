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
      _selectedIndex = index;
    });
  }

  Color _iconColor(int index) {
    return _selectedIndex == index ? Colors.blue : Color(0xFF778BA8);
  }

  Widget _buildIcon(String assetName, int index) {
    return SvgPicture.asset(
      assetName,
      color: _selectedIndex == index ? Colors.blue : Color(0xFF778BA8),
      key: ValueKey<int>(_selectedIndex), // Assurez-vous que la couleur de l'icône se met à jour.
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenue !'),
        backgroundColor: Color(0xFF15232E),
      ),
      body: SingleChildScrollView(
        // Votre contenu ici...
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF0F1E2B),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
        selectedItemColor: Colors.blue, // Pour les icônes et le texte sélectionné
        unselectedItemColor: Color(0xFF778BA8), // Pour les icônes et le texte non sélectionné
        selectedLabelStyle: TextStyle(color: Colors.blue), // Même couleur bleue pour le texte sélectionné
        unselectedLabelStyle: TextStyle(color: Color(0xFF778BA8)),// Couleur des icônes et textes non sélectionnés
        items: [
          BottomNavigationBarItem(
            icon: _buildIcon('assets/images/navbar_home.svg', 0),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon('assets/images/navbar_comics.svg', 1),
            label: 'Comics',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon('assets/images/navbar_series.svg', 2),
            label: 'Séries',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon('assets/images/navbar_movies.svg', 3),
            label: 'Films',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon('assets/images/navbar_search.svg', 4),
            label: 'Recherche',
          ),
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
