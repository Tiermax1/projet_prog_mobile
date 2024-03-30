import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'comics_event.dart';
import 'comics_state.dart';
import 'package:http/http.dart' as http;
import '../../config.dart'; // Mettez à jour le chemin si nécessaire

class ComicsBloc extends Bloc<ComicsEvent, ComicsState> {
  ComicsBloc() : super(ComicsInitial()) {
    on<FetchComicsEvent>((event, emit) async {
      emit(ComicsLoading());
      try {
        final response = await http.get(Uri.parse('https://comicvine.gamespot.com/api/issues?api_key=${Config.comicVineApiKey}&format=json'));
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          emit(ComicsLoaded(comicsList: data['results']));
        } else {
          emit(ComicsError('Failed to load comics'));
        }
      } catch (e) {
        emit(ComicsError(e.toString()));
      }
    });
  }
}
