import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'movies_event.dart';
import 'movies_state.dart';
import '../../config.dart'; // Assurez-vous que ce chemin est correct pour votre structure de projet

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(MoviesInitial()) {
    on<FetchMoviesEvent>((event, emit) async {
      emit(MoviesLoading());
      try {
        final response = await http.get(Uri.parse('https://comicvine.gamespot.com/api/movies?api_key=${Config.comicVineApiKey}&format=json'));
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          emit(MoviesLoaded(moviesList: data['results']));
        } else {
          emit(MoviesError('Failed to load movies'));
        }
      } catch (e) {
        emit(MoviesError(e.toString()));
      }
    });
  }
}
