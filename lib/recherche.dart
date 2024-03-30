import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'navBar.dart'; // Assurez-vous que c'est l'import correct pour votre NavBar personnalisée

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Supposons que 375 est la largeur basée sur la spécification de conception fournie
    double screenWidth = MediaQuery.of(context).size.width;
    double scaleFactor = screenWidth / 375;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recherche',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
            fontSize: 30 * scaleFactor, // Ajustez la taille de la police également
          ),
        ),
        backgroundColor: Color(0xFF223141),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Color(0xFF15232E),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF223141),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20 * scaleFactor),
                bottomRight: Radius.circular(20 * scaleFactor),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 13 * scaleFactor, vertical: 20 * scaleFactor),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Comic, film, série...',
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontFamily: 'Nunito',
                    fontSize: 17 * scaleFactor,
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  prefixIcon: Icon(Icons.search, color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35.0 * scaleFactor),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          Spacer(), // Utilisez Spacer pour pousser le contenu suivant vers le bas
          Container(
            width: double.infinity, // Prend toute la largeur possible
            padding: EdgeInsets.only(
              left: 25 * scaleFactor,
              top: 20 * scaleFactor,
              right: 25 * scaleFactor, // Espace à droite pour le texte
              bottom: 20 * scaleFactor,
            ),
            decoration: BoxDecoration(
              color: Color(0xFF1E3243),
              borderRadius: BorderRadius.circular(20 * scaleFactor),
            ),
            child: Stack(
              clipBehavior: Clip.none, // Permet aux éléments de déborder du container
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: 80 * scaleFactor, // Cet espace est réservé à droite du texte
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft, // Aligner le texte à gauche
                    child: Text(
                      'Saisissez une recherche pour trouver un comics, film, série ou personnage.',
                      style: TextStyle(
                        color: Color(0xFF1F9FFF),
                        fontFamily: 'Nunito',
                        fontSize: 18 * scaleFactor,
                        height: 1.333,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: -10 * scaleFactor, // Décale légèrement l'astronaute vers la droite
                  top: -55 * scaleFactor, // Décale légèrement l'astronaute vers le haut
                  child: SvgPicture.asset(
                    'assets/images/astronaut.svg',
                    width: 74.02 * scaleFactor,
                    height: 97 * scaleFactor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20 * scaleFactor),
          Spacer(), // Un autre Spacer pour équilibrer l'espacement
          // Ajoutez d'autres widgets ici au besoin
        ],
      ),
      bottomNavigationBar: NavBar(onItemSelected: (index) {
        // Mettez à jour l'interface utilisateur ou naviguez vers une nouvelle page ici
      }), // Assurez-vous que NavBar est défini dans navBar.dart
    );
  }
}
