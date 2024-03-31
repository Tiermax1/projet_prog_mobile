import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_prog_mobile/bloc/comics/comic_detail_bloc.dart';
import 'package:projet_prog_mobile/repository/comics_repository.dart';
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
import 'repository/comic_repository.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ComicsRepository>(
          create: (context) => ComicsRepository(),
        ),
        RepositoryProvider<ComicRepository>(
          create: (context) => ComicRepository(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final ComicsRepository comicsRepository = ComicsRepository();
  final ComicRepository comicRepository = ComicRepository();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        BlocProvider<ComicsBloc>(
          create: (context) => ComicsBloc(comicsRepository: comicsRepository),
        ),

        // Add other repositories here if necessary
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => NavBarBloc()),
          BlocProvider(create: (context) => MoviesBloc()),
          BlocProvider(create: (context) => SeriesBloc()),
          // Add other BlocProviders if necessary
        ],
        child: MaterialApp(
          title: 'Votre application',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MainScreen(),
        ),
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