import 'package:equatable/equatable.dart';
import '/models/comic_detail.dart'; // Update with your path

abstract class ComicDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class ComicDetailInitial extends ComicDetailState {}

class ComicDetailLoading extends ComicDetailState {}

class ComicDetailLoaded extends ComicDetailState {
  final ComicDetail comicDetail;

  ComicDetailLoaded(this.comicDetail);

}

class ComicDetailError extends ComicDetailState {
  final String error;

  ComicDetailError({required this.error});

  @override
  List<Object> get props => [error];
}
