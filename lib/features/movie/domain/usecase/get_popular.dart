import 'package:empaire_film/core/usecase/usecase.dart';
import 'package:empaire_film/features/movie/domain/entity/movie.dart';
import 'package:empaire_film/features/movie/domain/repository/movie_repository.dart';

class GetPopular implements Usecase<MovieEntity, void> {
  final MovieRepository repository;

  GetPopular(this.repository);

  @override
  Future<MovieEntity> call({void params}) {
    return repository.getPopularMovies();
  }
}
