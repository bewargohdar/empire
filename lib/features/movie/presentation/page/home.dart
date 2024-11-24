import 'package:empaire_film/features/movie/presentation/bloc/movie/movie_bloc.dart';
import 'package:empaire_film/features/movie/presentation/widget/app_bar/app_bar.dart';

import 'package:empaire_film/features/movie/presentation/widget/movie/movie_card.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final locale = context.locale;

    return Scaffold(
      appBar: mainAppBar(context),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieInitial) {
            context.read<MovieBloc>().add(GetPopularMovies());
          }
          if (state is MovieLoaded) {
            return RefreshIndicator(
              onRefresh: () => Future.delayed(
                const Duration(seconds: 0),
                () => context.read<MovieBloc>().add(GetPopularMovies()),
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
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  child: Divider(),
                ),
              ),
            );
          }
          if (state is MovieError) {
            return Center(
              child: Text(state.message.tr()),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
