import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'navBar.dart'; // Assurez-vous que le chemin vers nav_bar.dart est correct

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Calcul de la taille de l'astronaute par rapport à la taille de l'écran
    final double astronautWidth = MediaQuery.of(context).size.width * 0.4;
    final double astronautTop = MediaQuery.of(context).size.height * 0.2;

    return Scaffold(
      backgroundColor: Color(0xFF15232E), // Couleur de fond pour tout l'écran
      appBar: AppBar(
        backgroundColor: Color(0xFF15232E), // Couleur de fond de la AppBar
        elevation: 0, // Pas d'ombre
        title: Text(
          'Bienvenue !',
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset('assets/images/heart.svg'), // Remplacez par l'icône de coeur
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: astronautTop,
            right: 0,
            child: SvgPicture.asset(
              'assets/images/astronaut.svg', // Assurez-vous que le chemin d'accès est correct
              width: astronautWidth,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: astronautTop + astronautWidth / 2), // Demi-hauteur de l'astronaute pour le chevauchement
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSection(title: 'Séries populaires', context: context),
                // Ici, insérez votre liste horizontale ou autre widget pour les séries
                buildSection(title: 'Comics populaires', context: context),
                // Ici, insérez votre liste horizontale ou autre widget pour les comics
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavBar(onItemSelected: (index) {
        // Mettez à jour l'interface utilisateur ou naviguez vers une nouvelle page
      }),
    );
  }

  Widget buildSection({required String title, required BuildContext context}) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1E3243), // Couleur de fond pour les sections
        borderRadius: BorderRadius.circular(20), // Bords arrondis pour le conteneur
      ),
      margin: EdgeInsets.all(16.0), // Marge autour du conteneur
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0), // Padding à l'intérieur du conteneur
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF8100),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Logique de navigation pour "Voir plus"
                },
                child: Text(
                  'Voir plus',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 10), // Espace entre le titre et le contenu de la section
          // Ajoutez ici les widgets pour les séries ou comics, comme un CarouselSlider ou ListView.builder
        ],
      ),
    );
  }
}
