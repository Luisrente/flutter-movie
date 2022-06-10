import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Movie extends ChangeNotifier {
  String _apikey = 'e185627d7aca945569964ba1eeee4210';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  Movie() {
    print('lunis');
    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apikey, 'language': _language, 'page': '1'});
    final response = await http.get(url);
    print(response.body);
  }
  


}
