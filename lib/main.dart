import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/comics/comics_bloc.dart';
import 'bloc/movies/movies_bloc.dart';
import 'bloc/series/series_bloc.dart';
import 'bloc/nav_bar/nav_bar_bloc.dart';
import 'screens/home_screen.dart'; // Assurez-vous que les chemins des imports sont corrects
import 'screens/comics_screen.dart';
import 'screens/series_screen.dart';
import 'screens/movies_screen.dart';
import  'recherche.dart'; // J'ai supposé que c'est un écran de recherche
import 'widgets/nav_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Envoyer le BlocProvider au niveau supérieur pour couvrir tout MaterialApp
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavBarBloc()),
        BlocProvider(create: (_) => ComicsBloc()),
        BlocProvider(create: (_) => MoviesBloc()),
        BlocProvider(create: (_) => SeriesBloc()),
        // Ajoutez d'autres BlocProvider si nécessaire
      ],
      child: MaterialApp(
        title: 'Votre application',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onNavItemSelected,
      ),
    );
  }
}