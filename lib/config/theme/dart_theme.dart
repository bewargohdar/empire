import 'package:flutter/material.dart';

var kDarkColorSchema = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color(0xFF242A32),
);

final darkTheme = ThemeData.dark().copyWith(
  colorScheme: kDarkColorSchema,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme().copyWith(
    backgroundColor: kDarkColorSchema.onPrimaryContainer,
    foregroundColor: kDarkColorSchema.primaryContainer,
  ),
  cardTheme: const CardTheme().copyWith(
    color: kDarkColorSchema.secondaryContainer,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kDarkColorSchema.primaryContainer,
      foregroundColor: kDarkColorSchema.onPrimaryContainer,
    ),
  ),
  textTheme: ThemeData().textTheme.copyWith(
        titleLarge: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 20,
          color: kDarkColorSchema.onSecondary,
        ),
      ),
);
