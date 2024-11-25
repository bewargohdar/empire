import 'package:flutter/material.dart';

var kColorSchema = ColorScheme.fromSeed(seedColor: const Color(0x242A32));

final lightTheme = ThemeData().copyWith(
  colorScheme: kColorSchema,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme().copyWith(
    backgroundColor: kColorSchema.onPrimaryContainer,
    foregroundColor: kColorSchema.primaryContainer,
  ),
  cardTheme: const CardTheme().copyWith(
    color: kColorSchema.secondaryContainer,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kColorSchema.primaryContainer,
      foregroundColor: kColorSchema.onPrimaryContainer,
    ),
  ),
  textTheme: ThemeData().textTheme.copyWith(
        titleLarge: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 20,
          color: kColorSchema.onSecondary,
        ),
      ),
);
