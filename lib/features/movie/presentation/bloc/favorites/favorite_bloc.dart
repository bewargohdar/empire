import 'package:bloc/bloc.dart';

import 'package:empaire_film/features/movie/domain/entity/movie.dart';
import 'package:empaire_film/features/movie/domain/usecase/get_favorite_movie.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecase/add_favorite_movie.dart';
import '../../../domain/usecase/remove_favorite_movie.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  GetFavoriateMovie getFavoriteMovies;
  AddFavoriteMovie addFavoriteMovie;
  RemoveFavoriteMovie removeFavoriteMovie;

  FavoriteBloc(
    this.getFavoriteMovies,
    this.addFavoriteMovie,
    this.removeFavoriteMovie,
  ) : super(FavoriteInitial()) {
    on<GetFavoriteMovies>(_getFavoriteMovies);
    on<InsertFavoriteEvent>(_addFavoriteMovie);
    on<DeleteFavoriteMovie>(_removeFavoriteMovie);
  }

  Future<void> _getFavoriteMovies(
      GetFavoriteMovies event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoading());
    try {
      final movies = await getFavoriteMovies();
      print('Loaded favorites: ${movies.map((m) => m.id).toList()}');
      emit(FavoriteLoaded(movies));
    } catch (e) {
      emit(FavoriteError('Failed to fetch favorite movies'));
    }
  }

  Future<void> _addFavoriteMovie(
      InsertFavoriteEvent event, Emitter<FavoriteState> emit) async {
    try {
      await addFavoriteMovie(params: event.movie);
      // After adding, reload the favorites list
      final updatedMovies = await getFavoriteMovies();
      emit(FavoriteLoaded(updatedMovies));
    } catch (e) {
      emit(AddFavoriteFailed());
    }
  }

  Future<void> _removeFavoriteMovie(
      DeleteFavoriteMovie event, Emitter<FavoriteState> emit) async {
    try {
      await removeFavoriteMovie(params: event.movie);
      // After removing, reload the favorites list
      final updatedMovies = await getFavoriteMovies();
      emit(FavoriteLoaded(updatedMovies));
    } catch (e) {
      emit(RemoveFavoriteFailed());
    }
  }
}
