part of 'favorite_bloc.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<MovieData> movies;

  FavoriteLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

final class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError(this.message);

  @override
  List<Object> get props => [message];
}

final class AddFavoriteSuccess extends FavoriteState {}

final class AddFavoriteFailed extends FavoriteState {}

final class RemoveFavoriteSuccess extends FavoriteState {}

final class RemoveFavoriteFailed extends FavoriteState {}
