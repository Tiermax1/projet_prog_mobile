import 'package:projet_prog_mobile/models/comics.dart';
import 'package:equatable/equatable.dart';

abstract class ComicsState extends Equatable {
  @override
  List<Object> get props => [];
}

class ComicsInitial extends ComicsState {}

class ComicsLoading extends ComicsState {}

class ComicsLoaded extends ComicsState {
  final List<Comics> comicsList;

  ComicsLoaded({required this.comicsList});

  @override
  List<Object> get props => [comicsList];
}

class ComicsError extends ComicsState {
  final String message;

  ComicsError(this.message);
}
