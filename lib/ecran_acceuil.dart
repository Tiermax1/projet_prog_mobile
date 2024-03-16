import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'navBar.dart'; // Assurez-vous que le chemin vers nav_bar.dart est correct

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Utilisez les dimensions et positions comme définies dans vos captures d'écran.
    final double astronautSize = 121.85;
    final double astronautRight = MediaQuery.of(context).size.width - astronautSize - 244; // La position X de l'astronaute doit être ajustée ici
    final double astronautTop = 16; // La position Y de l'astronaute doit être ajustée ici

    final double sectionWidth = 424; // La largeur de la section doit être ajustée ici
    final double sectionHeight = 329; // La hauteur de la section doit être ajustée ici
    final double sectionTop = 107; // La position Y de la section doit être ajustée ici

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
            right: astronautRight,
            child: SvgPicture.asset(
              'assets/images/astronaut.svg', // Assurez-vous que le chemin d'accès est correct
              width: astronautSize,
              height: astronautSize,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: sectionTop),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSection(
                      title: 'Séries populaires',
                      width: sectionWidth,
                      height: sectionHeight,
                      context: context
                  ),
                  // Ici, insérez votre liste horizontale ou autre widget pour les séries
                  buildSection(
                      title: 'Comics populaires',
                      width: sectionWidth,
                      height: sectionHeight,
                      context: context
                  ),
                  // Ici, insérez votre liste horizontale ou autre widget pour les comics
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavBar(onItemSelected: (index) {
        // Mettez à jour l'interface utilisateur ou naviguez vers une nouvelle page
      }),
    );
  }

  Widget buildSection({required String title, required double width, required double height, required BuildContext context}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Color(0xFF1E3243), // Couleur de fond pour les sections
        borderRadius: BorderRadius.circular(20), // Bords arrondis pour le conteneur
      ),
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Marge autour du conteneur
      padding: EdgeInsets.all(16.0), // Padding à l'intérieur du conteneur
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF8100),
            ),
          ),
          // Ajoutez ici les widgets pour les séries ou comics, comme un CarouselSlider ou ListView.builder
        ],
      ),
    );
  }
}
