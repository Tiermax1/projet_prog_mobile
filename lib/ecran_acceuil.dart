import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'navBar.dart'; // Assurez-vous que ce chemin est correct

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF15232E), // Couleur de fond de la AppBar
        elevation: 0, // Pas d'ombre
        actions: [
          // Ajout de l'astronaute à l'AppBar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SvgPicture.asset(
              'assets/images/astronaut.svg', // Assurez-vous que le chemin d'accès est correct
              width: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xFF15232E), // Couleur de fond pour "Bienvenue !"
              width: double.infinity, // Prendre toute la largeur disponible
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Bienvenue !',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            // Ajout des encadrés pour les séries et comics populaires
            buildSectionTitle('Séries populaires', Color(0xFF1E3243)),
            // TODO: Ajoutez ici votre liste horizontale de séries
            buildSectionTitle('Comics populaires', Color(0xFF1E3243)),
            // TODO: Ajoutez ici votre liste horizontale de comics
          ],
        ),
      ),
      bottomNavigationBar: NavBar(onItemSelected: (index) {
        print('Item $index sélectionné');
      }),
    );
  }

  Widget buildSectionTitle(String title, Color backgroundColor) {
    return Container(
      color: backgroundColor, // Couleur de fond pour les titres des sections
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF8100), // Couleur du texte pour les titres des sections
            ),
          ),
          TextButton(
            onPressed: () {
              // Ajoutez votre logique de navigation pour "Voir plus"
            },
            child: Text(
              'Voir plus',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
