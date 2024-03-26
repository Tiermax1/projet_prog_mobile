import 'package:flutter/material.dart';
import 'package:projet_prog_mobile/liste_comics.dart';
import 'package:projet_prog_mobile/liste_films.dart';
import 'package:projet_prog_mobile/recherche.dart';
import 'ecran_acceuil.dart'; // Importez HomeScreen depuis ecran_acceuil.dart
import 'liste_serie.dart'; // Importez SeriesScreen depuis liste_serie.dart

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Votre application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(), // Assurez-vous que HomeScreen est bien défini dans ecran_acceuil.dart
      routes: {
        '/home': (context) => HomeScreen(),
        '/comics': (context) => ComicsScreen(),
        '/series': (context) => SeriesScreen(),
        '/films': (context) => FilmsScreen(),
        '/search': (context) => SearchPage(),
        // Page de comics// Page de comics// Ajoutez une route pour la SeriesScreen
      },
    );
  }
}
