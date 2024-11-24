import 'package:empaire_film/features/movie/domain/entity/movie.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../../utils/local_database/data_base_helper.dart';
import '../../models/movie.dart';

class MovieLocalDataSource {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  // Add movie to favorites
  Future<bool> addMovieToFavorites(MovieData movie) async {
    final db = await _databaseHelper.database;
    try {
      await db.insert(
        'movies',
        movie.toMap(), // Ensure `MovieModel` has a `toMap()` method
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  // Remove movie from favorites
  Future<bool> removeMovieFromFavorites(MovieData movie) async {
    final db = await _databaseHelper.database;
    try {
      await db.delete(
        'movies',
        where: 'id = ?',
        whereArgs: [movie.id], // `movie.id` should come from `MovieData`
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<MovieData>> getFavoriteMovies() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>>? maps = await db.query('movies');

    if (maps == null || maps.isEmpty) {
      return []; // Return an empty list if no data is found
    }

    // Map the query result to a list of MovieModel objects
    return maps.map((movieMap) {
      return MovieData.fromMap(
          movieMap); // Ensure `MovieModel` has a `fromMap` method
    }).toList();
  }

  // Check if a movie is already in favorites
  Future<bool> isMovieInFavorites(int id) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'movies',
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps
        .isNotEmpty; // Returns true if the movie is found in the database
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final movieDataSource = MovieLocalDataSource();

  // Test data
  final movie = MovieData(
    id: 1,
    title: "Inception",
    overview: "A mind-bending thriller by Christopher Nolan.",
    releaseDate: "2010-07-16",
  );

  // Add a movie to favorites
  bool added = await movieDataSource.addMovieToFavorites(movie);
  print('Movie added to favorites: $added');

  // Check if the movie is in favorites
  bool isFavorite = await movieDataSource.isMovieInFavorites(movie.id!);
  print('Is the movie in favorites? $isFavorite');

  // Get all favorite movies
  List<MovieData> favoriteMovies = await movieDataSource.getFavoriteMovies();
  print('Favorite Movies:');
  for (var favMovie in favoriteMovies) {
    print(' - ${favMovie.title}');
  }

  // Remove a movie from favorites
  bool removed = await movieDataSource.removeMovieFromFavorites(movie);
  print('Movie removed from favorites: $removed');

  // Verify the movie is removed
  isFavorite = await movieDataSource.isMovieInFavorites(movie.id!);
  print('Is the movie in favorites after removal? $isFavorite');
}
