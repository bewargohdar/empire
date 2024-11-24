import 'package:empaire_film/features/movie/data/models/movie.dart';
import 'package:empaire_film/features/movie/domain/entity/movie.dart';

import '../../data/models/single_movie.dart';

abstract class MovieRepository {
  Future<MovieModel> getPopularMovies();
  Future<SingleMovieModel> getMovieDetails(int id);
  //add favorite movie functions
  Future<bool> addMovieToFavorites(MovieData movie);
  Future<bool> removeMovieFromFavorites(MovieData movie);
  Future<List<MovieData>> getFavoriteMovies();
}
