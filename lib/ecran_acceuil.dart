import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'navBar.dart'; // Assurez-vous que le chemin vers nav_bar.dart est correct

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Taille de l'écran pour le positionnement relatif
    final screenSize = MediaQuery.of(context).size;
    // Ajuster la taille de l'astronaute à 50% de la largeur de l'écran
    final double astronautSize = screenSize.width * 0.5;
    // Décaler l'astronaute pour qu'il soit partiellement caché à droite
    final double astronautRight = astronautSize / 8;
    // Placer l'astronaute à 10% du haut de l'écran
    final double astronautTop = screenSize.height * 0.00001;

    return Scaffold(
      backgroundColor: Color(0xFF15232E), // Couleur de fond pour tout l'écran
      appBar: AppBar(
        backgroundColor: Color(0xFF15232E), // Couleur de fond de la AppBar
        elevation: 0, // Pas d'ombre<
        title: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 30),
          // Ajustez si nécessaire pour aligner le texte "Bienvenue !"
          child: Text(
            'Bienvenue !',
            style: TextStyle(
                fontFamily: 'Nunito',
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: astronautTop,
            right: astronautRight,
            child: SvgPicture.asset(
              'assets/images/astronaut.svg',
              // Assurez-vous que le chemin d'accès est correct
              width: astronautSize,
              height: astronautSize,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenSize.height * 0.1),
                buildSection(
                    title: 'Séries populaires',
                    width: screenSize.width * 0.9, // Ajustez si nécessaire
                    height: screenSize.height * 0.3, // Ajustez si nécessaire
                    context: context,
                    onSeeMorePressed: () {}),
                // Ici, insérez votre liste horizontale ou autre widget pour les séries
                buildSection(
                    title: 'Comics populaires',
                    width: screenSize.width * 0.9, // Ajustez si nécessaire
                    height: screenSize.height * 0.3, // Ajustez si nécessaire
                    context: context,
                    onSeeMorePressed: () {}),
                buildSection(
                    title: 'Films populaires',
                    width: screenSize.width * 0.9, // Ajustez si nécessaire
                    height: screenSize.height * 0.3, // Ajustez si nécessaire
                    context: context,
                    onSeeMorePressed: () {}),
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

  Widget buildSection({
    required String title,
    required double width,
    required double height,
    required BuildContext context,
    required VoidCallback
        onSeeMorePressed, // Ajouter un callback pour gérer l'appui sur le bouton
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Color(0xFF1E3243),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // Aligner les éléments de Row aux extrémités de l'axe principal
            children: [
              Row(
                children: [
                  Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFA500), // Couleur orange pour le rond
                      shape: BoxShape.circle,
                    ),
                    margin:
                        EdgeInsets.only(right: 8.0), // Marge à droite du rond
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: onSeeMorePressed, // Utilisez le callback ici
                child: Text(
                  'Voir plus',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: Colors.white,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFF0F1E2B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        18), // Rayon arrondi pour les bords
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                ),
              ),
            ],
          ),
          // Ajoutez ici les widgets pour les séries ou comics, comme un CarouselSlider ou ListView.builder
        ],
      ),
    );
  }

  Widget buildItem(Map<String, String> item) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          Image.asset(
            item['imagePath']!,
            height: 150, // Exemple de hauteur, ajustez selon vos besoins
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8.0),
          Text(
            item['title']!,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Nunito',
            ),
          ),
        ],
      ),
    );
  }

}
