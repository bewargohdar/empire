// lib/injection.dart
import 'package:empaire_film/features/movie/data/repository/movie_repository_impl.dart';
import 'package:empaire_film/features/movie/data/source/local/local_data_source.dart';
import 'package:empaire_film/features/movie/data/source/remote/movie_data_source.dart';
import 'package:empaire_film/features/movie/domain/repository/movie_repository.dart';
import 'package:empaire_film/features/movie/domain/usecase/get_popular.dart';
import 'package:empaire_film/features/movie/presentation/bloc/favorites/favorite_bloc.dart';
import 'package:empaire_film/features/movie/presentation/bloc/movie/movie_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/movie/domain/usecase/add_favorite_movie.dart';
import 'features/movie/domain/usecase/get_favorite_movie.dart';
import 'features/movie/domain/usecase/get_now_playing.dart';
import 'features/movie/domain/usecase/get_single_movie.dart';
import 'features/movie/domain/usecase/get_up_comming.dart';
import 'features/movie/domain/usecase/remove_favorite_movie.dart';
import 'features/movie/presentation/bloc/single_movie/single_movie_bloc.dart';

final sl = GetIt.instance;

void init() {
  // Bloc
  sl.registerFactory(
    () => MovieBloc(
      getNowPlaying: sl(),
      getUpComming: sl(),
      getPopular: sl(),
    ),
  );
  sl.registerFactory(() => SingleMovieBloc(sl()));
  sl.registerFactory(() => FavoriteBloc(sl(), sl(), sl()));

  // Use cases
  sl.registerLazySingleton(() => GetNowPlaying(sl()));
  sl.registerLazySingleton(() => GetUpComming(sl()));
  sl.registerLazySingleton(() => GetPopular(sl()));
  sl.registerLazySingleton(() => GetSingleMovie(sl()));
  sl.registerLazySingleton(() => GetFavoriateMovie(sl()));
  sl.registerLazySingleton(() => AddFavoriteMovie(sl()));
  sl.registerLazySingleton(() => RemoveFavoriteMovie(sl()));

  // Repository
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(sl(), sl()),
  );

  // Data source
  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSource(),
  );
  sl.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSource(),
  );
}
