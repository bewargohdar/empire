// lib/injection.dart
import 'package:empaire_film/features/movie/data/repository/movie_repository_impl.dart';
import 'package:empaire_film/features/movie/data/source/remote/movie_data_source.dart';
import 'package:empaire_film/features/movie/domain/repository/movie_repository.dart';
import 'package:empaire_film/features/movie/domain/usecase/get_popular.dart';
import 'package:empaire_film/features/movie/presentation/bloc/bloc/movie_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/movie/domain/usecase/get_now_playing.dart';
import 'features/movie/domain/usecase/get_single_movie.dart';
import 'features/movie/domain/usecase/get_up_comming.dart';
import 'features/movie/presentation/bloc/bloc/single_movie_bloc.dart';

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
  sl.registerFactory(
    () => SingleMovieBloc(
      sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetNowPlaying(sl()));
  sl.registerLazySingleton(() => GetUpComming(sl()));
  sl.registerLazySingleton(() => GetPopular(sl()));
  sl.registerLazySingleton(() => GetSingleMovie(sl()));

  // Repository
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(sl()),
  );

  // Data source
  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSource(),
  );
}
