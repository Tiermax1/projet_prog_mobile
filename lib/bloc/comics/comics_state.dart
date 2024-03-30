abstract class ComicsState {}

class ComicsInitial extends ComicsState {}

class ComicsLoading extends ComicsState {}

class ComicsLoaded extends ComicsState {
  final List<dynamic> comicsList;

  ComicsLoaded({required this.comicsList});
}

class ComicsError extends ComicsState {
  final String message;

  ComicsError(this.message);
}
