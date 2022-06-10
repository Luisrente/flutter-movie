import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie/helpers/debouncer.dart';
import 'package:movie/models/models.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/models/now_playing_response.dart';
import 'package:movie/models/popular_response.dart';
import 'package:movie/models/search_response.dart';

class MoviesProvider extends ChangeNotifier {
  String _apikey = 'e185627d7aca945569964ba1eeee4210';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 1;

  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));

  final StreamController<List<Movie>> _suggestionStreamController =
      new StreamController.broadcast();

  Stream<List<Movie>> get suggestStream =>
      this._suggestionStreamController.stream;

  MoviesProvider() {
    // print('Movies Provider inicializado');
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJsonData(String paramet, [int page = 1]) async {
    var url = Uri.https(_baseUrl, paramet,
        {'api_key': _apikey, 'language': _language, 'page': '${page}'});
    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    // if( response.statusCode != 200) return print()
    //final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    // final Map<String, dynamic> decodedData = json.decode(response.body);
    // print(nowPlayingResponse.results[1].title);
    //onDisplayMovies = nowPlayingResponse.results;
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await this._getJsonData('3/movie/now_playing');
    // if( response.statusCode != 200) return print()
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    // final Map<String, dynamic> decodedData = json.decode(response.body);
    // print(nowPlayingResponse.results[1].title);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    print('Entro');
    final jsonData = await this._getJsonData('3/movie/popular');
    final popularResponse = PopularResponse.fromJson(jsonData);
    // final Map<String, dynamic> decodedData = json.decode(response.body);
    // print(nowPlayingResponse.results[1].title);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    print('piendo peti');
    final jsonData = await this._getJsonData('3/movie/$movieId/credits');
    final creditsResponse = Credits.fromJson(jsonData);
    moviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie',
        {'api_key': _apikey, 'language': _language, 'query': query});
    final response = await http.get(url);
    final searchResponde = SearchResponse.fromJson(response.body);
    return searchResponde.results;
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      //print('tenemos valor a b ${value}');
      final results = await this.searchMovie(value);
      this._suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }
}
