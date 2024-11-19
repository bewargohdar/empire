part of 'single_movie_bloc.dart';

sealed class SingleMovieState extends Equatable {
  const SingleMovieState();

  @override
  List<Object> get props => [];
}

final class SingleMovieInitial extends SingleMovieState {}

final class SingleMovieLoading extends SingleMovieState {}

class SingleMovieLoaded extends SingleMovieState {
  final SingleMovieEntity movie;

  SingleMovieLoaded(this.movie);
}

final class SingleMovieError extends SingleMovieState {
  final String message;

  SingleMovieError(this.message);

  @override
  List<Object> get props => [message];
}
