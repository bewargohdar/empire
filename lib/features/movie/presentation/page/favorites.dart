import 'package:cached_network_image/cached_network_image.dart';
import 'package:empaire_film/features/movie/domain/entity/movie.dart';
import 'package:empaire_film/features/movie/presentation/bloc/favorites/favorite_bloc.dart';
import 'package:empaire_film/features/movie/presentation/bloc/single_movie/single_movie_bloc.dart';
import 'package:empaire_film/features/movie/presentation/page/movie_detail.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    context.read<FavoriteBloc>().add(GetFavoriteMovies());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(builder: (context, state) {
      if (state is FavoriteInitial) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is FavoriteLoaded) {
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Divider(),
          ),
          itemCount: state.movies.length,
          itemBuilder: (context, index) {
            final data = state.movies[index];
            return FavoriteCard(
              data: data,
            );
          },
        );
      } else if (state is FavoriteError) {
        return Center(
          child: Text(state.message),
        );
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({super.key, required this.data});

  final MovieData data;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      dragStartBehavior: DragStartBehavior.down,
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerRight,
        child: Icon(
          Iconsax.trash,
          size: 33,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
      key: ValueKey(data.id),
      onDismissed: (direction) {
        context.read<FavoriteBloc>().add(
              DeleteFavoriteMovie(data),
            );
      },
      child: InkWell(
        onTap: () {
          context.read<SingleMovieBloc>().add(
                FetchSingleMovie(data.id!),
              );
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MovieDetailScreen(
                movie: data,
              ),
            ),
          );
        },
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Hero(
                  tag: 'favorite-movie-${data.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://image.tmdb.org/t/p/w500${data.posterPath ?? ''}",
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => const SizedBox(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 2,
                child: OverflowBar(
                  spacing: 5,
                  overflowSpacing: 10,
                  alignment: MainAxisAlignment.center,
                  overflowAlignment: OverflowBarAlignment.start,
                  children: [
                    Text(
                      data.title ?? "",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      data.overview ?? '',
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
