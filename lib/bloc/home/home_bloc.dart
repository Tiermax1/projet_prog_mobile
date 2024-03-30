import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'home_event.dart';
import 'home_state.dart';
import 'package:http/http.dart' as http;
import '../../config.dart'; // Mettez à jour ce chemin pour correspondre à la structure de votre projet

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<LoadDataEvent>((event, emit) async {
      emit(HomeLoadingState());
      try {
        final series = await _fetchDataFromApi('series_list'); // Utilisez les noms d'endpoints corrects
        final comics = await _fetchDataFromApi('issues');
        final movies = await _fetchDataFromApi('movies');
        emit(HomeLoadedState(series: series, comics: comics, movies: movies));
      } catch (e) {
        emit(HomeErrorState(e.toString()));
      }
    });
  }

  Future<List<dynamic>> _fetchDataFromApi(String endpoint) async {
    final String apiKey = Config.comicVineApiKey; // Assurez-vous que la classe Config est correctement définie
    final String apiUrl = 'https://comicvine.gamespot.com/api/$endpoint?api_key=$apiKey&format=json';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final result = json.decode(response.body)['results'];
      return result;
    } else {
      throw Exception('Failed to load data from $endpoint');
    }
  }
}
