abstract class SeriesState {}

class SeriesInitial extends SeriesState {}

class SeriesLoading extends SeriesState {}

class SeriesLoaded extends SeriesState {
  final List<dynamic> seriesList;

  SeriesLoaded({required this.seriesList});
}

class SeriesError extends SeriesState {
  final String message;

  SeriesError(this.message);
}
