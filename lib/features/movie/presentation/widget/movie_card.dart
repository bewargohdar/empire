import 'package:cached_network_image/cached_network_image.dart';
import 'package:empaire_film/features/movie/domain/entity/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:ui' as ui;

import '../bloc/bloc/single_movie_bloc.dart';
import '../page/movie_detail.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.data, this.isEven = false});

  final MovieData data;
  final bool isEven;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<SingleMovieBloc>().add(FetchSingleMovie(data.id!));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(movie: data),
          ),
        );
      },
      child: SizedBox(
        height: 150,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Hero(
                tag: data.id ?? "movie_image_tag",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/w500${data.posterPath}',
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => const SizedBox(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
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
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Icon(
                          Iconsax.star1,
                          size: 12,
                          color: Theme.of(context).hintColor,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "${data.voteAverage?.toStringAsFixed(1)}/10 IMDb",
                          textDirection: ui.TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context).hintColor),
                        ),
                      ],
                    ),
                    Text(
                      data.overview ?? '',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    Wrap(
                      spacing: 10,
                      runSpacing: 5,
                      children: [
                        Chip(
                          label: Text(
                            data.releaseDate ?? '',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        ),
                        Chip(
                          label: Text(
                            data.originalLanguage ?? '',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
            const SizedBox(
              width: 16,
            ),
          ],
        ),
      ),
    );
  }
}
