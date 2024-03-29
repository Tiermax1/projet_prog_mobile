import 'package:flutter/material.dart';
import 'liste_comics.dart';
import 'liste_films.dart';
import 'recherche.dart';
import 'ecran_acceuil.dart';
import 'liste_serie.dart';
import 'navBar.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    ComicsScreen(),
    SeriesScreen(),
    FilmsScreen(),
    SearchPage(),
  ];

  void _onNavItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Votre application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: NavBar(
          selectedIndex: _selectedIndex,
          onItemSelected: _onNavItemSelected,
        ),
      ),
    );
  }
}
