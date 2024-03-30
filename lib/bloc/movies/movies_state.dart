abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<dynamic> moviesList;

  MoviesLoaded({required this.moviesList});
}

class MoviesError extends MoviesState {
  final String message;

  MoviesError(this.message);
}
