import 'package:flutter/material.dart';
import 'navBar.dart'; // Assurez-vous que le chemin d'importation est correct

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Titre de l\'application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NavBar(), // Utilisez AccueilPage comme page d'accueil
    );
  }
}
