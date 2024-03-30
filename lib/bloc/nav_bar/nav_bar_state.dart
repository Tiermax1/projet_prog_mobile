abstract class NavBarState {}

class NavBarSelectedState extends NavBarState {
  final int selectedIndex;

  NavBarSelectedState(this.selectedIndex);
}