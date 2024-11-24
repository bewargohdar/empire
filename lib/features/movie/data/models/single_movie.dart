import 'package:empaire_film/features/movie/domain/entity/movie.dart';
import 'package:empaire_film/features/movie/domain/entity/single_movie.dart';

class SingleMovieModel extends SingleMovieEntity {
  SingleMovieModel(
      {required super.adult,
      required super.backdropPath,
      required super.budget,
      required super.genres,
      required super.homepage,
      required super.id,
      required super.imdbId,
      required super.originalLanguage,
      required super.originalTitle,
      required super.overview,
      required super.popularity,
      required super.posterPath,
      required super.productionCompanies,
      required super.productionCountries,
      required super.releaseDate,
      required super.revenue,
      required super.runtime,
      required super.spokenLanguages,
      required super.status,
      required super.tagline,
      required super.title,
      required super.video,
      required super.voteAverage,
      required super.voteCount,
      required super.isFavorite});

  factory SingleMovieModel.fromJson(Map<String, dynamic> json) {
    return SingleMovieModel(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      budget: json['budget'],
      genres: json['genres'] != null
          ? List<Genres>.from(
              json['genres'].map((x) => Genres.fromJson(x)).toList())
          : [],
      homepage: json['homepage'],
      id: json['id'],
      imdbId: json['imdb_id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'],
      posterPath: json['poster_path'],
      productionCompanies: json['production_companies'] != null
          ? List<ProductionCompanies>.from(json['production_companies']
              .map((x) => ProductionCompanies.fromJson(x))
              .toList())
          : [],
      productionCountries: json['production_countries'] != null
          ? List<ProductionCountries>.from(json['production_countries']
              .map((x) => ProductionCountries.fromJson(x))
              .toList())
          : [],
      releaseDate: json['release_date'],
      revenue: json['revenue'],
      runtime: json['runtime'],
      spokenLanguages: json['spoken_languages'] != null
          ? List<SpokenLanguages>.from(json['spoken_languages']
              .map((x) => SpokenLanguages.fromJson(x))
              .toList())
          : [],
      status: json['status'],
      tagline: json['tagline'],
      title: json['title'],
      video: json['video'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
      isFavorite: false,
    );
  }
}

class Genres extends GenresEntity {
  Genres({
    required super.id,
    required super.name,
  });

  factory Genres.fromJson(Map<String, dynamic> json) {
    return Genres(
      id: json['id'],
      name: json['name'],
    );
  }
}

class ProductionCompanies extends ProductionCompaniesEntity {
  ProductionCompanies({
    required super.id,
    required super.logoPath,
    required super.name,
    required super.originCountry,
  });

  factory ProductionCompanies.fromJson(Map<String, dynamic> json) {
    return ProductionCompanies(
      id: json['id'],
      logoPath: json['logo_path'],
      name: json['name'],
      originCountry: json['origin_country'],
    );
  }
}

class ProductionCountries extends ProductionCountryEntity {
  ProductionCountries({
    required super.iso31661,
    required super.name,
  });

  factory ProductionCountries.fromJson(Map<String, dynamic> json) {
    return ProductionCountries(
      iso31661: json['iso_3166_1'],
      name: json['name'],
    );
  }
}

class SpokenLanguages extends SpokenLanguageEntity {
  SpokenLanguages({
    required super.englishName,
    required super.iso6391,
    required super.name,
  });

  factory SpokenLanguages.fromJson(Map<String, dynamic> json) {
    return SpokenLanguages(
      englishName: json['english_name'],
      iso6391: json['iso_639_1'],
      name: json['name'],
    );
  }
}

extension SingleMovieExt on SingleMovieEntity {
  MovieData castToMovieData() {
    return MovieData(
        id: id, title: title, overview: overview, posterPath: posterPath);
  }
}

extension ListExt on List {
  bool findById(int id) {
    if (isNotEmpty) {
      try {
        return firstWhere((element) => element.id == id) != -1;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }
}
