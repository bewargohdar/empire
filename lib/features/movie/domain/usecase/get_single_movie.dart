import 'package:empaire_film/core/usecase/usecase.dart';

import '../../data/models/single_movie.dart';
import '../repository/movie_repository.dart';

class GetSingleMovie implements Usecase<SingleMovieModel, int> {
  final MovieRepository repository;

  GetSingleMovie(this.repository);

  @override
  Future<SingleMovieModel> call({int? params}) {
    return repository.getMovieDetails(params!);
  }
}
