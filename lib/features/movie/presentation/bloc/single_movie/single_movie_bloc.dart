import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/single_movie.dart';
import '../../../domain/usecase/get_single_movie.dart';

part 'single_movie_event.dart';
part 'single_movie_state.dart';

class SingleMovieBloc extends Bloc<SingleMovieEvent, SingleMovieState> {
  final GetSingleMovie getSingleMovie;
  SingleMovieBloc(
    this.getSingleMovie,
  ) : super(SingleMovieInitial()) {
    on<FetchSingleMovie>(_fethSingleMovie);
  }

  Future<void> _fethSingleMovie(
      FetchSingleMovie event, Emitter<SingleMovieState> emit) async {
    emit(SingleMovieLoading());
    try {
      final movies = await getSingleMovie(params: event.id);

      emit(SingleMovieLoaded(movies));
    } catch (e) {
      emit(SingleMovieError('Failed to fetch now playing movies'));
    }
  }
}
