import 'package:empaire_film/core/usecase/usecase.dart';
import 'package:empaire_film/features/movie/domain/entity/movie.dart';

import '../repository/movie_repository.dart';

class RemoveFavoriteMovie implements Usecase<bool, MovieData> {
  final MovieRepository repository;

  RemoveFavoriteMovie(this.repository);

  @override
  Future<bool> call({MovieData? params}) {
    return repository.removeMovieFromFavorites(params!);
  }
}
