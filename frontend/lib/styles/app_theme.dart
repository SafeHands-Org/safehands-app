import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: Colors.blue,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), // Define primary color
  textTheme: const TextTheme( // Define text styles
    displayLarge: TextStyle(
      fontSize: 72,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: Colors.black,
    ),
  ),
);