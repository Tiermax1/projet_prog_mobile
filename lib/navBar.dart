import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

typedef NavCallback = void Function(int index);

class NavBar extends StatefulWidget {
  final int selectedIndex;
  final NavCallback onItemSelected;

  NavBar({Key? key, required this.selectedIndex, required this.onItemSelected})
      : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  void _onItemTapped(int index) {
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF15232E), // Utilisez ici la couleur de fond souhaitée.
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFF15232E), // Assurez-vous que cette couleur est identique à celle du Container.
          currentIndex: widget.selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Color(0xFF778BA8),
          items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/navbar_home.svg',
                  color: widget.selectedIndex == 0
                      ? Colors.blue
                      : Color(0xFF778BA8),
                ),
                label: 'Accueil',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/navbar_comics.svg',
                  color: widget.selectedIndex == 1
                      ? Colors.blue
                      : Color(0xFF778BA8),
                ),
                label: 'Comics',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/navbar_series.svg',
                  color: widget.selectedIndex == 2
                      ? Colors.blue
                      : Color(0xFF778BA8),
                ),
                label: 'Séries',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/navbar_movies.svg',
                  color: widget.selectedIndex == 3
                      ? Colors.blue
                      : Color(0xFF778BA8),
                ),
                label: 'Films',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/navbar_search.svg',
                  color: widget.selectedIndex == 4
                      ? Colors.blue
                      : Color(0xFF778BA8),
                ),
                label: 'Recherche',
              ),
            ],
          ),
        ),
      );

  }
}
