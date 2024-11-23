import 'package:equatable/equatable.dart';

class SingleMovieEntity extends Equatable {
  final bool? adult;
  final String? backdropPath;
  final int? budget;
  final List<Genres>? genres;
  final String? homepage;
  final int? id;
  final String? imdbId;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<ProductionCompanies>? productionCompanies;
  final List<ProductionCountry>? productionCountries;
  final String? releaseDate;
  final int? revenue;
  final int? runtime;
  final List<SpokenLanguage>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;
  final bool? isFavorite;

  SingleMovieEntity(
      {this.adult,
      this.backdropPath,
      this.budget,
      this.genres,
      this.isFavorite,
      this.homepage,
      this.id,
      this.imdbId,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.productionCompanies,
      this.productionCountries,
      this.releaseDate,
      this.revenue,
      this.runtime,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount});

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        budget,
        genres,
        homepage,
        id,
        imdbId,
        originalLanguage,
        originalTitle,
        overview,
        popularity,
        posterPath,
        productionCompanies,
        productionCountries,
        releaseDate,
        revenue,
        runtime,
        spokenLanguages,
        status,
        tagline,
        title,
        video,
        voteAverage,
        voteCount,
        isFavorite
      ];
}

class Genres extends Equatable {
  final int id;
  final String name;

  Genres({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}

class ProductionCompanies extends Equatable {
  final int id;
  final String logoPath;
  final String name;
  final String originCountry;

  ProductionCompanies({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  @override
  List<Object?> get props => [id, logoPath, name, originCountry];
}

class ProductionCountry extends Equatable {
  final String iso31661;
  final String name;

  ProductionCountry({
    required this.iso31661,
    required this.name,
  });

  @override
  List<Object?> get props => [iso31661, name];
}

class SpokenLanguage extends Equatable {
  final String englishName;
  final String iso6391;
  final String name;

  SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });
  @override
  List<Object?> get props => [englishName, iso6391, name];
}
