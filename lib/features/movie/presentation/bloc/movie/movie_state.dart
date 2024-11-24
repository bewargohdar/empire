part of 'movie_bloc.dart';

sealed class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

final class MovieInitial extends MovieState {}

final class MovieLoading extends MovieState {}

final class MovieLoaded extends MovieState {
  final MovieEntity movies;

  const MovieLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

final class MovieError extends MovieState {
  final String message;

  const MovieError(this.message);

  @override
  List<Object> get props => [message];
}
