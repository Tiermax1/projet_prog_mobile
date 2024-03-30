import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../bloc/nav_bar/nav_bar_bloc.dart';
import '../bloc/nav_bar/nav_bar_event.dart';
import '../bloc/nav_bar/nav_bar_state.dart';
typedef NavCallback = void Function(int index);

class NavBar extends StatelessWidget {
  final int selectedIndex;
  final NavCallback onItemSelected;
  NavBar({Key? key, required this.selectedIndex, required this.onItemSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarBloc, NavBarState>(
      builder: (context, state) {
        int currentIndex = state is NavBarSelectedState ? state.selectedIndex : 0;

        return Container(
          decoration: BoxDecoration(
            color: Color(0xFF15232E),
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
              backgroundColor: Color(0xFF15232E),
              currentIndex: currentIndex,
              onTap: (index) {
                // Utilisez l'événement correct ici
                BlocProvider.of<NavBarBloc>(context).add(ChangeTabEvent(index));
                onItemSelected(index);
              },
              selectedItemColor: Colors.blue,
              unselectedItemColor: Color(0xFF778BA8),
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/navbar_home.svg',
                    color: currentIndex == 0 ? Colors.blue : Color(0xFF778BA8),
                  ),
                  label: 'Accueil',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/navbar_comics.svg',
                    color: currentIndex == 1 ? Colors.blue : Color(0xFF778BA8),
                  ),
                  label: 'Comics',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/navbar_series.svg',
                    color: currentIndex == 2 ? Colors.blue : Color(0xFF778BA8),
                  ),
                  label: 'Séries',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/navbar_movies.svg',
                    color: currentIndex == 3 ? Colors.blue : Color(0xFF778BA8),
                  ),
                  label: 'Films',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/navbar_search.svg',
                    color: currentIndex == 4 ? Colors.blue : Color(0xFF778BA8),
                  ),
                  label: 'Recherche',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
