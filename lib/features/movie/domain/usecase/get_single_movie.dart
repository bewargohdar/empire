import 'package:empaire_film/core/usecase/usecase.dart';
import 'package:empaire_film/features/movie/domain/entity/single_movie.dart';

import '../repository/movie_repository.dart';

class GetSingleMovie implements Usecase<SingleMovieEntity, int> {
  final MovieRepository repository;

  GetSingleMovie(this.repository);

  @override
  Future<SingleMovieEntity> call({int? params}) {
    return repository.getMovieDetails(params!);
  }
}
