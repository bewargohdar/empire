import 'package:flutter/material.dart';

class MovieDetailScreen extends StatelessWidget {
  final dynamic movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title ?? 'Movie Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            movie.backdropPath != null
                ? Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.backdropPath}')
                : const SizedBox.shrink(),
            const SizedBox(height: 16),
            Text(
              movie.title ?? 'Unknown Title',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              movie.overview ?? 'No description available.',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                Text('${movie.voteAverage?.toStringAsFixed(1)}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
