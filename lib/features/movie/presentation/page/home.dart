import 'package:empaire_film/features/movie/presentation/bloc/bloc/movie_bloc.dart';
import 'package:empaire_film/features/movie/presentation/widget/app_bar.dart';
import 'package:empaire_film/features/movie/presentation/widget/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: mainAppBar(context),
        body: BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
          if (state is MovieInitial) {
            context.read<MovieBloc>().add(GetPopularMovies());
          }
          if (state is MovieLoaded) {
            return RefreshIndicator(
              onRefresh: () => Future.delayed(
                const Duration(seconds: 0),
                () => context.read<MovieBloc>().add(
                      GetPopularMovies(),
                    ),
              ),
              child: ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                  itemCount: state.movies.results?.length ?? 0,
                  itemBuilder: (context, index) {
                    final movie = state.movies.results?[index];
                    return MovieCard(data: movie!, isEven: index.isEven);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        child: Divider(),
                      )),
            );
          }
          if (state is MovieError) {
            return Center(
              child: Text(state.message),
            );
          }
          return SizedBox();
        }));
  }
}
