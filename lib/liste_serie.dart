import 'package:flutter/material.dart';
import 'navBar.dart'; // Votre NavBar personnalisée

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SeriesScreen(),
    );
  }
}

class SeriesScreen extends StatelessWidget {
  final Color backgroundColor = Color(0xFF15232E);
  final Color cardBackgroundColor = Color(0xFF1E3243);
  final Color titleColor = Colors.white;
  final double topPadding = 0.0; // Ajustez cette valeur en fonction de l'image fournie

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: Container(
        color: backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: topPadding), // Espace en haut pour le titre
            Padding(
              padding: const EdgeInsets.only(left: 32), // Espace à gauche pour le titre
              child: Text(
                'Séries les plus populaires',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  color: titleColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 24), // Espace entre le titre et les sections
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Ajustez le nombre d'éléments de la liste ici
                itemBuilder: (context, index) {
                  return buildSection('Section ${index + 1}', cardBackgroundColor);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(onItemSelected: (index) {
        print('Selected index $index');
      }),
    );
  }

  Widget buildSection(String title, Color color) {
    return Container(
      height: 150, // Hauteur fixe pour les sections, ajustez selon la capture d'écran
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Ajustez selon la capture d'écran
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Nunito',
            color: titleColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Sous-titre', // Remplacez ceci par les données réelles
          style: TextStyle(
            fontFamily: 'Nunito',
            color: Colors.white.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
