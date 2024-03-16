import 'package:flutter/material.dart';
import 'ecran_acceuil.dart'; // Utilisez le nouveau nom de fichier après renommage

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.orange, // Utilisez secondary au lieu de accentColor
        ),
      ),
      home: HomeScreen(), // Assurez-vous que HomeScreen est bien défini dans ecran_accueil.dart
    );
  }
}
