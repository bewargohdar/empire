import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:empaire_film/features/movie/data/models/single_movie.dart';
import 'package:empaire_film/features/movie/domain/entity/movie.dart';
import 'package:empaire_film/features/movie/presentation/widget/app_bar.dart';
import 'package:empaire_film/features/movie/presentation/widget/stretchable_app_bar.dart';
import 'package:empaire_film/features/movie/presentation/widget/tag_card.dart';
import 'package:empaire_film/utils/constant/lang_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:ui' as ui;

import '../bloc/bloc/single_movie_bloc.dart';

class MovieDetailScreen extends StatelessWidget {
  final MovieData movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        slivers: [
          DetailHeader(movie: movie),
          SliverToBoxAdapter(
            child: BlocBuilder<SingleMovieBloc, SingleMovieState>(
              builder: (context, state) {
                if (state is SingleMovieInitial) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SingleMovieLoaded) {
                  final movie = state.movie;
                  return DetailBody(data: movie);
                } else if (state is SingleMovieLoading) {
                  return Center(child: Text(state.toString()));
                } else {
                  return const Center(child: Text('Something went wrong!'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DetailBody extends StatelessWidget {
  const DetailBody({
    super.key,
    required this.data,
  });

  final SingleMovieModel data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  data.title ?? "",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              const Icon(
                Iconsax.star1,
                size: 12,
                color: Colors.yellow,
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
          const SizedBox(
            height: 16,
          ),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(
              data.genres?.length ?? 0,
              (index) => TagCard(text: data.genres![index].name ?? ''),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            LangKeys.description.tr(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            data.overview ?? "",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: Theme.of(context).hintColor,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            LangKeys.productionCompanies.tr(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 8,
          ),
          Wrap(
            children:
                List.generate(data.productionCountries?.length ?? 0, (index) {
              ProductionCompanies company = data.productionCompanies![index];
              return company.logoPath != null
                  ? Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 2, color: const Color(0xffDBE3FF)),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${company.logoPath ?? ''}',
                        errorWidget: (context, url, error) => const SizedBox(),
                      ),
                    )
                  : const SizedBox();
            }),
          )
        ],
      ),
    );
  }
}

class DetailHeader extends StatelessWidget {
  const DetailHeader({
    super.key,
    required this.movie,
  });

  final MovieData movie;

  @override
  Widget build(BuildContext context) {
    return StretchableAppBar(
      stretchModes: const [
        StretchMode.blurBackground,
        StretchMode.zoomBackground
      ],
      expandedHeight: 400,
      leading: InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
          height: 50,
          width: 50,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5), shape: BoxShape.circle),
          child: Icon(
            Icons.arrow_back,
            size: 28,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      background: Hero(
        tag: movie.id ?? "movie_image_tag",
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: CachedNetworkImageProvider(
                'https://image.tmdb.org/t/p/w500${movie.posterPath ?? ''}',
              ),
            ),
          ),
          width: double.infinity,
        ),
      ),
    );
  }
}
