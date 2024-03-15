import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavBar extends StatefulWidget {
  // Ajoutez un constructeur avec une clé
  NavBar({Key? key}) : super(
      key: key); // Assurez-vous d'ajouter un constructeur avec un paramètre 'key'.

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
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
    // Augmentez la taille des icônes avec les paramètres width et height
    return SvgPicture.asset(
      assetName,
      width: 25, // Spécifiez la largeur souhaitée
      height: 25, // Spécifiez la hauteur souhaitée
      color: _selectedIndex == index ? Colors.blue : Color(0xFF778BA8),
      key: ValueKey<int>(
          _selectedIndex), // Assurez-vous que la couleur de l'icône se met à jour.
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Votre contenu ici...
      ),
      bottomNavigationBar: Container(
        height:80,
        decoration: BoxDecoration(
          color: Color(0xFF0F1E2B),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              spreadRadius: 0,
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent, // Fond transparent pour laisser voir le Container
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            showUnselectedLabels: true,
            selectedItemColor: Colors.blue, // Pour les icônes et le texte sélectionné
            unselectedItemColor: Color(0xFF778BA8), // Pour les icônes et le texte non sélectionné
            selectedLabelStyle: TextStyle(color: Colors.blue), // Même couleur bleue pour le texte sélectionné
            unselectedLabelStyle: TextStyle(color: Color(0xFF778BA8)), // Couleur des icônes et textes non sélectionnés
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
          ),
        ),
      );
  }
}


  void main() {
    runApp(MaterialApp(
      home: NavBar(),
    ));
  }
