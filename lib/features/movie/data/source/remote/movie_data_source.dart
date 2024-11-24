import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/movie.dart';
import '../../models/single_movie.dart';

const String apiKey = '7d1f7566dfd0681a04138c8cd65dd90c';
const String baseUrl = 'https://api.themoviedb.org/3/movie/now_playing';
const String detailsUrl = 'https://api.themoviedb.org/3/movie/';
const String tradingUrl = 'https://api.themoviedb.org/3/trending/movie/day';

class MovieRemoteDataSource {
  Future<MovieModel> getPopularMovies() async {
    final uri = Uri.parse('$tradingUrl?api_key=$apiKey');
    final response = await http.get(uri);

    return _parseMovies(response);
  }

  MovieModel _parseMovies(http.Response response) {
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return MovieModel.fromJson(json);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<SingleMovieModel> getMovieDetails(int id) async {
    final uri = Uri.parse('$detailsUrl$id?api_key=$apiKey');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return SingleMovieModel.fromJson(json);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<MovieModel> getSearchMovies(String query) async {
    final uri = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query');
    final response = await http.get(uri);
    return _parseMovies(response);
  }
}
