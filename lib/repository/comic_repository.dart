import 'dart:convert';
import 'method.dart';
import 'package:http/http.dart' as http;
import 'package:projet_prog_mobile/bloc/comics/comic_detail_state.dart';
import 'package:projet_prog_mobile/models/comic_detail.dart'; // Update with the correct path

class ComicRepository {
  final String _baseUrl = 'https://comicvine.gamespot.com/api';
  final String _apiKey = 'e7af0ec9f79d827bf98b15ae290e22495814110d';

  Future<ComicDetail> fetchComicDetail({required String apiDetailUrl}) async {
    final url = Uri.parse('$apiDetailUrl?api_key=$_apiKey&format=json&field_list=id,image,name,volume,issue_number,cover_date,character_credits,person_credits,api_detail_url,description');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ComicDetail.fromJson(data['results']);
    } else {
      return handleError(response.statusCode);
    }
  }
}