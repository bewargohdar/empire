part of 'single_movie_bloc.dart';

sealed class SingleMovieEvent extends Equatable {
  const SingleMovieEvent();

  @override
  List<Object> get props => [];
}

final class FetchSingleMovie extends SingleMovieEvent {
  final int id;

  FetchSingleMovie(this.id);

  @override
  List<Object> get props => [id];
}

final class SingleMovieScuccessEvent extends SingleMovieEvent {}

final class SingleMovieErrorEvent extends SingleMovieEvent {}
