import 'package:bloc/bloc.dart';
import 'package:empaire_film/features/movie/domain/entity/movie.dart';
import 'package:empaire_film/features/movie/domain/usecase/get_now_playing.dart';
import 'package:empaire_film/features/movie/domain/usecase/get_popular.dart';
import 'package:empaire_film/features/movie/domain/usecase/get_up_comming.dart';
import 'package:equatable/equatable.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlaying getNowPlaying;
  final GetUpComming getUpComming;
  final GetPopular getPopular;
  MovieBloc({
    required this.getNowPlaying,
    required this.getUpComming,
    required this.getPopular,
  }) : super(MovieInitial()) {
    on<GetNowPlayingMovies>(_getNowPlayingMovies);
    on<GetUpComingMovies>(_getUpCommingMovies);
    on<GetPopularMovies>(_getPopularMovies);
  }

  Future<void> _getNowPlayingMovies(
      GetNowPlayingMovies event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    try {
      final movies = await getNowPlaying();
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(const MovieError('Failed to fetch now playing movies'));
    }
  }

  Future<void> _getUpCommingMovies(
      GetUpComingMovies event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    try {
      final movies = await getUpComming();
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(MovieError('Failed to fetch upcoming movies'));
    }
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
