abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<dynamic> series;
  final List<dynamic> comics;
  final List<dynamic> movies;

  HomeLoadedState({required this.series, required this.comics, required this.movies});
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState(this.message);
}
