import 'package:flutter_bloc/flutter_bloc.dart';
import 'nav_bar_event.dart';
import 'nav_bar_state.dart';

class NavBarBloc extends Bloc<NavBarEvent, NavBarState> {
  NavBarBloc() : super(NavBarSelectedState(0)) {
    on<ChangeTabEvent>((event, emit) {
      emit(NavBarSelectedState(event.tabIndex));
    });
  }
}
