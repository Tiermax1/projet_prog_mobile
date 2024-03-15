import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AccueilPage extends StatefulWidget {
  // Ajoutez un constructeur avec une clé
  AccueilPage({Key? key}) : super(key: key); // Assurez-vous d'ajouter un constructeur avec un paramètre 'key'.

  @override
  _AccueilPageState createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  @override
  Widget build(BuildContext context) {
    // Votre UI sera construit ici
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenue !'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Ajoutez des sections pour les séries populaires et les comics ici
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          // Ajoutez d'autres items ici
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AccueilPage(),
  ));
}
