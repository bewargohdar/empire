import 'package:empaire_film/features/movie/data/models/movie.dart';
import 'package:empaire_film/features/movie/data/models/single_movie.dart';
import 'package:empaire_film/features/movie/data/source/local/local_data_source.dart';
import 'package:empaire_film/features/movie/data/source/remote/movie_data_source.dart';
import 'package:empaire_film/features/movie/domain/entity/movie.dart';

import 'package:empaire_film/features/movie/domain/repository/movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  MovieRemoteDataSource movieRemoteDataSource;
  MovieLocalDataSource movieLocalDataSource;

  MovieRepositoryImpl(this.movieRemoteDataSource, this.movieLocalDataSource);

  @override
  Future<MovieModel> getNowPlayingMovies() {
    return movieRemoteDataSource.getNowPlayingMovies();
  }

  @override
  Future<MovieModel> getPopularMovies() {
    return movieRemoteDataSource.getPopularMovies();
  }

  @override
  Future<MovieModel> getUpComingMovies() {
    return movieRemoteDataSource.getUpComingMovies();
  }

  @override
  Future<SingleMovieModel> getMovieDetails(int id) async {
    return movieRemoteDataSource.getMovieDetails(id);
  }

  @override
  Future<MovieModel> getTrendingMovies() {
    return movieRemoteDataSource.getTrendingMovies();
  }

  @override
  Future<MovieModel> getSearchMovies(String query) {
    return movieRemoteDataSource.getSearchMovies(query);
  }

  @override
  Future<bool> addMovieToFavorites(MovieData movie) {
    return movieLocalDataSource.addMovieToFavorites(movie);
  }

  @override
  Future<List<MovieData>> getFavoriteMovies() {
    return movieLocalDataSource.getFavoriteMovies();
  }

  @override
  Future<bool> removeMovieFromFavorites(MovieData movie) {
    return movieLocalDataSource.removeMovieFromFavorites(movie);
  }
}
