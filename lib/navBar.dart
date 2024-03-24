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

    switch (_selectedIndex) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/comics'); // Assurez-vous qu'il n'y a pas d'espace ici
        break;

      case 2:
      // Navigator logic for "Séries" tab
        Navigator.pushNamed(context, '/series');
        break;
      case 3:
        Navigator.pushNamed(context, '/films');
        break;
      case 4:
       Navigator.pushNamed(context, '/search');
        break;
      default:
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
