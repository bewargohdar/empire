import 'package:empaire_film/features/movie/data/models/movie.dart';
import 'package:empaire_film/features/movie/data/models/single_movie.dart';
import 'package:empaire_film/features/movie/data/source/remote/movie_data_source.dart';

import 'package:empaire_film/features/movie/domain/repository/movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  MovieRemoteDataSource movieRemoteDataSource;

  MovieRepositoryImpl(this.movieRemoteDataSource);

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
}
