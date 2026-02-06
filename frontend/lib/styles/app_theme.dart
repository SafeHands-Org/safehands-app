import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.purple;
  static const Color inputFill = Color(0x1A9C27B0);

  static const TextStyle title = TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 20,
    color: Color.fromARGB(255, 95, 94, 94),
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: Colors.black,
  ); 

  static const TextStyle button = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle link = TextStyle(
    fontSize: 14,
    color: primary,
    decoration: TextDecoration.underline,
  );

  static InputDecoration inputDecoration({
    String? hintText,
    IconData? icon,
  }) {
    return InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      fillColor: inputFill,
      filled: true,
      prefixIcon: icon != null ? Icon(icon, color: primary) : null,
    );
  }

  static final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: primary,
    shape: const StadiumBorder(),
    padding: const EdgeInsets.symmetric(vertical: 16),
  );

  static ThemeData themeData = ThemeData(
    primaryColor: primary,
    elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: primary)
    )
  );
}