import 'package:empaire_film/features/movie/domain/entity/movie.dart';

class MovieModel extends MovieEntity {
  MovieModel({
    required super.page,
    required super.totalResults,
    required super.totalPages,
    required super.results,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      page: json['page'],
      totalResults: json['total_results'],
      totalPages: json['total_pages'],
      results: List<MovieData>.from(
          json['results'].map((x) => MovieData.fromJson(x))),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'total_results': totalResults,
      'total_pages': totalPages,
      'results': results?.map((x) => x.toMap()).toList(),
    };
  }
}
