import 'package:bloc/bloc.dart';
import 'package:empaire_film/features/movie/domain/entity/movie.dart';
import 'package:empaire_film/features/movie/domain/usecase/get_popular.dart';
import 'package:equatable/equatable.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopular getPopular;
  MovieBloc({
    required this.getPopular,
  }) : super(MovieInitial()) {
    on<GetPopularMovies>(_getPopularMovies);
  }

  Future<void> _getPopularMovies(
      GetPopularMovies event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    try {
      final movies = await getPopular();
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(MovieError('Failed to fetch popular movies'));
    }
  }
}
