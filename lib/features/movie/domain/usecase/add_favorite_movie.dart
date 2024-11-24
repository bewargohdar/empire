import 'package:empaire_film/core/usecase/usecase.dart';

import 'package:empaire_film/features/movie/domain/entity/movie.dart';

import 'package:empaire_film/features/movie/domain/repository/movie_repository.dart';

class AddFavoriteMovie implements Usecase<bool, MovieData> {
  final MovieRepository repository;

  AddFavoriteMovie(this.repository);

  @override
  Future<bool> call({MovieData? params}) {
    return repository.addMovieToFavorites(params!);
  }
}
