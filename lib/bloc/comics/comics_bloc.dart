import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/comics_repository.dart';
import 'comics_event.dart';
import 'comics_state.dart';


class ComicsBloc extends Bloc<ComicsEvent, ComicsState> {
  final ComicsRepository comicsRepository;

  ComicsBloc({required this.comicsRepository}) : super(ComicsInitial()) {
    on<FetchComicsEvent>((event, emit) async {
      emit(ComicsLoading());
      try {
        final comicsList = await comicsRepository.fetchComics(limit: event.limit);
        emit(ComicsLoaded(comicsList: comicsList)); // corrected here
      } catch (e) {
        emit(ComicsError(e.toString()));
      }
    });
  }
}
