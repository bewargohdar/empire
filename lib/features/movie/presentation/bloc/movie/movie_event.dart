part of 'movie_bloc.dart';

sealed class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

final class GetNowPlayingMovies extends MovieEvent {}

final class GetPopularMovies extends MovieEvent {}

final class GetUpComingMovies extends MovieEvent {}
