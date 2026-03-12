import 'dart:io';

import 'package:flutter/material.dart';

class AppTheme {
  static Color primary = Colors.purple.shade400;
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

  static final TextStyle link = TextStyle(
    fontSize: 14,
    color: primary,
    decoration: TextDecoration.underline,
  );

  static InputDecoration inputDecoration({
    bool? filled,
    Color? fillColor,
    String? hintText,
    IconData? icon,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Color? iconColor,
    InputBorder? border,
    EdgeInsetsGeometry? contentPadding
  }) {
    return InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      fillColor: const Color(0xFFF0F0F0),
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }

  static final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.purple.shade400,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    elevation: 0,
  );

  static ThemeData themeData = ThemeData(
    primaryColor: primary,
    textTheme: Platform.isIOS
      ? const TextTheme( // IOS defined style formats
        displayLarge:   TextStyle(fontFamily: '.SF Pro Display', fontSize: 57, fontWeight: FontWeight.w400),
        displayMedium:  TextStyle(fontFamily: '.SF Pro Display', fontSize: 45, fontWeight: FontWeight.w400),
        displaySmall:   TextStyle(fontFamily: '.SF Pro Display', fontSize: 36, fontWeight: FontWeight.w400),
        headlineLarge:  TextStyle(fontFamily: '.SF Pro Display', fontSize: 32, fontWeight: FontWeight.w600),
        headlineMedium: TextStyle(fontFamily: '.SF Pro Display', fontSize: 28, fontWeight: FontWeight.w600),
        headlineSmall:  TextStyle(fontFamily: '.SF Pro Display', fontSize: 24, fontWeight: FontWeight.w600),
        titleLarge:     TextStyle(fontFamily: '.SF Pro Text', fontSize: 22, fontWeight: FontWeight.w600),
        titleMedium:    TextStyle(fontFamily: '.SF Pro Text', fontSize: 16, fontWeight: FontWeight.w600),
        titleSmall:     TextStyle(fontFamily: '.SF Pro Text', fontSize: 14, fontWeight: FontWeight.w500),
        bodyLarge:      TextStyle(fontFamily: '.SF Pro Text', fontSize: 16, fontWeight: FontWeight.w400),
        bodyMedium:     TextStyle(fontFamily: '.SF Pro Text', fontSize: 14, fontWeight: FontWeight.w400),
        bodySmall:      TextStyle(fontFamily: '.SF Pro Text', fontSize: 12, fontWeight: FontWeight.w400),
        labelLarge:     TextStyle(fontFamily: '.SF Pro Text', fontSize: 14, fontWeight: FontWeight.w500),
        labelMedium:    TextStyle(fontFamily: '.SF Pro Text', fontSize: 12, fontWeight: FontWeight.w500),
        labelSmall:     TextStyle(fontFamily: '.SF Pro Text', fontSize: 11, fontWeight: FontWeight.w500),
      )
    : const TextTheme( // Android defined style formats
        displayLarge:   TextStyle(fontFamily: 'Roboto', fontSize: 57),
        displayMedium:  TextStyle(fontFamily: 'Roboto', fontSize: 45),
        displaySmall:   TextStyle(fontFamily: 'Roboto', fontSize: 36),
        headlineLarge:  TextStyle(fontFamily: 'Roboto', fontSize: 32),
        headlineMedium: TextStyle(fontFamily: 'Roboto', fontSize: 28),
        headlineSmall:  TextStyle(fontFamily: 'Roboto', fontSize: 24),
        titleLarge:     TextStyle(fontFamily: 'Roboto', fontSize: 22),
        titleMedium:    TextStyle(fontFamily: 'Roboto', fontSize: 16),
        titleSmall:     TextStyle(fontFamily: 'Roboto', fontSize: 14),
        bodyLarge:      TextStyle(fontFamily: 'Roboto', fontSize: 16),
        bodyMedium:     TextStyle(fontFamily: 'Roboto', fontSize: 14),
        bodySmall:      TextStyle(fontFamily: 'Roboto', fontSize: 12),
        labelLarge:     TextStyle(fontFamily: 'Roboto', fontSize: 14),
        labelMedium:    TextStyle(fontFamily: 'Roboto', fontSize: 12),
        labelSmall:     TextStyle(fontFamily: 'Roboto', fontSize: 11),
      ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: primary)
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.purple,
      foregroundColor: Colors.white,
      scrolledUnderElevation: 4.0,
    )
  );
}