import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'series_event.dart';
import 'series_state.dart';
import '../../config.dart'; // Make sure this path is correct for your project structure

class SeriesBloc extends Bloc<SeriesEvent, SeriesState> {
  SeriesBloc() : super(SeriesInitial()) {
    on<FetchSeriesEvent>((event, emit) async {
      emit(SeriesLoading());
      try {
        final response = await http.get(Uri.parse('https://comicvine.gamespot.com/api/series_list?api_key=${Config.comicVineApiKey}&format=json'));
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          emit(SeriesLoaded(seriesList: data['results']));
        } else {
          emit(SeriesError('Failed to load series'));
        }
      } catch (e) {
        emit(SeriesError(e.toString()));
      }
    });
  }
}
