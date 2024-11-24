import 'package:sqflite/sqflite.dart';

Future<void> createFavoritesTable(Database db) async {
  await db.execute('''
      CREATE TABLE movies (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        image TEXT,
        created_at TEXT
      )
    ''');
}
