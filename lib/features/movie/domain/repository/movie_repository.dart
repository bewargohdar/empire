import 'package:empaire_film/features/movie/data/models/movie.dart';

import '../../data/models/single_movie.dart';

abstract class MovieRepository {
  Future<MovieModel> getNowPlayingMovies();
  Future<MovieModel> getUpComingMovies();
  Future<MovieModel> getPopularMovies();
  Future<SingleMovieModel> getMovieDetails(int id);
  Future<MovieModel> getTrendingMovies();
  Future<MovieModel> getSearchMovies(String query);
}
