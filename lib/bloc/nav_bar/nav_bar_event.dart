abstract class NavBarEvent {}

class ChangeTabEvent extends NavBarEvent {
  final int tabIndex;

  ChangeTabEvent(this.tabIndex);
}
