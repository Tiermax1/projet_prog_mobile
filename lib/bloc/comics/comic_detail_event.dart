import 'package:equatable/equatable.dart';

abstract class ComicDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchComicDetailEvent extends ComicDetailEvent {
  final String apiDetailUrl;

  FetchComicDetailEvent({required this.apiDetailUrl});

  @override
  List<Object> get props => [apiDetailUrl];
}
