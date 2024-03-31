import 'package:flutter_bloc/flutter_bloc.dart';
import 'comic_detail_event.dart'; // Assurez-vous que le chemin est correct
import 'comic_detail_state.dart'; // Assurez-vous que le chemin est correct
import 'package:projet_prog_mobile/repository/comic_repository.dart'; // Assurez-vous que le chemin est correct
import 'package:projet_prog_mobile/models/comic_detail.dart';

class ComicDetailBloc extends Bloc<ComicDetailEvent, ComicDetailState> {
  final ComicRepository comicRepository;

  ComicDetailBloc({required this.comicRepository}) : super(ComicDetailInitial()) {
    on<FetchComicDetailEvent>((event, emit) async {
      emit(ComicDetailLoading());
      try {
        final comic = await comicRepository.fetchComicDetail(apiDetailUrl: event.apiDetailUrl);
        emit(ComicDetailLoaded(comic));
      } catch (e) {
        emit(ComicDetailError(error: e.toString()));
      }
    });
  }
}