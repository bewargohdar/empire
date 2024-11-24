import 'package:empaire_film/core/usecase/usecase.dart';
import 'package:empaire_film/features/movie/domain/entity/movie.dart';
import 'package:empaire_film/features/movie/domain/repository/movie_repository.dart';

class GetFavoriateMovie implements Usecase<List<MovieData>, void> {
  final MovieRepository repository;

  GetFavoriateMovie(this.repository);

  @override
  Future<List<MovieData>> call({void params}) {
    return repository.getFavoriteMovies();
  }
}
