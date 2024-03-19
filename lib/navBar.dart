import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

typedef NavCallback = void Function(int index);

class NavBar extends StatefulWidget {
  final NavCallback onItemSelected;

  NavBar({Key? key, required this.onItemSelected}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 2) { // Si l'onglet "Séries" est sélectionné, utilisez Navigator pour afficher la SeriesScreen
      Navigator.pushNamed(context, '/series');
    } else {
      widget.onItemSelected(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xFF0F1E2B),
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Color(0xFF778BA8),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/navbar_home.svg',
            color: _selectedIndex == 0 ? Colors.blue : Color(0xFF778BA8),
          ),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/navbar_comics.svg',
            color: _selectedIndex == 1 ? Colors.blue : Color(0xFF778BA8),
          ),
          label: 'Comics',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/navbar_series.svg',
            color: _selectedIndex == 2 ? Colors.blue : Color(0xFF778BA8),
          ),
          label: 'Séries',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/navbar_movies.svg',
            color: _selectedIndex == 3 ? Colors.blue : Color(0xFF778BA8),
          ),
          label: 'Films',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/navbar_search.svg',
            color: _selectedIndex == 4 ? Colors.blue : Color(0xFF778BA8),
          ),
          label: 'Recherche',
        ),
      ],
    );
  }
}
