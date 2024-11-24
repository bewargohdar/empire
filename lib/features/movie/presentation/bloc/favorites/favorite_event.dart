part of 'favorite_bloc.dart';

sealed class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

final class GetFavoriteMovies extends FavoriteEvent {}

final class InsertFavoriteEvent extends FavoriteEvent {
  final MovieData movie;

  InsertFavoriteEvent(this.movie);

  @override
  List<Object> get props => [movie];
}

final class DeleteFavoriteMovie extends FavoriteEvent {
  final MovieData movie;

  DeleteFavoriteMovie(this.movie);

  @override
  List<Object> get props => [movie];
}

class FetchingFavoritesEvent extends FavoriteEvent {}

class FetchingFavoritesSuccessEvent extends FavoriteEvent {}

class FetchingFavoritesFailedEvent extends FavoriteEvent {}
