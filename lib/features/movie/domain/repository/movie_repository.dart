import 'package:empaire_film/features/movie/data/models/movie.dart';

import 'package:empaire_film/features/movie/domain/entity/single_movie.dart';

abstract class MovieRepository {
  Future<MovieModel> getNowPlayingMovies();
  Future<MovieModel> getUpComingMovies();
  Future<MovieModel> getPopularMovies();
  Future<SingleMovieEntity> getMovieDetails(int id);
}
