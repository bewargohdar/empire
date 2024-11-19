import 'package:easy_localization/easy_localization.dart';
import 'package:empaire_film/features/movie/presentation/bloc/bloc/movie_bloc.dart';
import 'package:empaire_film/features/movie/presentation/page/movie_detail.dart';
import 'package:empaire_film/features/movie/presentation/page/setting.dart';
import 'package:empaire_film/utils/constant/lang_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void navigateToDetails(BuildContext context, dynamic movie) {
    if (movie != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => MovieDetailScreen(movie: movie),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                LangKeys.nowShowing.tr(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            sliver: SliverToBoxAdapter(child: SizedBox(height: 8)),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: _buildNowShowingCarousel(context),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            sliver: SliverToBoxAdapter(child: SizedBox(height: 8)),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                LangKeys.comingSoon.tr(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            sliver: SliverToBoxAdapter(child: SizedBox(height: 8)),
          ),
          _buildComingSoonList(context),
          const SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            sliver: SliverToBoxAdapter(child: SizedBox(height: 8)),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                LangKeys.popular.tr(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            sliver: SliverToBoxAdapter(child: SizedBox(height: 8)),
          ),
          _buildPopularList(context),
          // Add bottom padding
          const SliverPadding(
            padding: EdgeInsets.only(bottom: 16.0),
            sliver: SliverToBoxAdapter(child: SizedBox(height: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      floating: true,
      title: Text(LangKeys.appName.tr()),
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(
            Iconsax.setting_2,
            size: 26,
          ),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SettingsScreen(),
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {/* Implement notifications functionality */},
        ),
      ],
    );
  }

  Widget _buildNowShowingCarousel(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieInitial) {
          BlocProvider.of<MovieBloc>(context).add(GetNowPlayingMovies());
        }
        if (state is MovieLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MovieLoaded) {
          return RefreshIndicator(
            onRefresh: () async => Future.delayed(Duration.zero, () {
              BlocProvider.of<MovieBloc>(context).add(GetNowPlayingMovies());
            }),
            child: CarouselSlider.builder(
              itemCount: state.movies.results?.length,
              itemBuilder: (context, index, _) {
                final movie = state.movies.results?[index];
                return _buildCarouselItem(context, movie);
              },
              options: CarouselOptions(
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
              ),
            ),
          );
        } else if (state is MovieError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildCarouselItem(BuildContext context, dynamic movie) {
    return InkWell(
      onTap: () => navigateToDetails(context, movie),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie.title,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComingSoonList(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieLoading) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is MovieLoaded) {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: CustomScrollView(
                scrollDirection: Axis.horizontal,
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _buildMovieCard(
                            context, state.movies.results?[index]);
                      },
                      childCount: state.movies.results?.length ?? 0,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is MovieError) {
          return SliverToBoxAdapter(
            child: Center(child: Text(state.message)),
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }

  Widget _buildPopularList(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieLoading) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is MovieLoaded) {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: CustomScrollView(
                scrollDirection: Axis.horizontal,
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _buildMovieCard(
                            context, state.movies.results?[index]);
                      },
                      childCount: state.movies.results?.length ?? 0,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is MovieError) {
          return SliverToBoxAdapter(
            child: Center(child: Text(state.message)),
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }

  Widget _buildMovieCard(BuildContext context, dynamic movie) {
    return InkWell(
      onTap: () => navigateToDetails(context, movie),
      child: Container(
        margin: const EdgeInsets.all(6.0),
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: NetworkImage(
              'https://image.tmdb.org/t/p/original${movie.backdropPath}',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Text(
                  movie.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
