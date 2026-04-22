import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_dim.dart';
import 'app_scheme.dart';

abstract final class AppTheme {
  static ThemeData light() {
    const cs = AppColorsLight.scheme;
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColorsLight.scheme,
      extensions: [PaletteExtension.light()],
      scaffoldBackgroundColor: cs.surface,

      cardTheme: CardThemeData(
        color: cs.surface,
        elevation: 0,
        shadowColor: cs.shadow.withValues(alpha: 0.03),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.borderRadiusCard,
          side: BorderSide(color: cs.outlineVariant),
        ),
        margin: EdgeInsets.zero,
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: cs.surface,
        indicatorColor: cs.primary.withValues(alpha: 0.12),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return IconThemeData(color: cs.primary);
          return IconThemeData(color: cs.onSurfaceVariant);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: cs.primary);
          return TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: cs.onSurfaceVariant);
        }),
      ),

      dividerTheme: DividerThemeData(color: cs.outlineVariant, thickness: 1),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cs.surfaceContainerHighest,
        hintStyle: TextStyle(color: cs.onSurfaceVariant.withValues(alpha: 0.7)),
        prefixIconColor: cs.onSurfaceVariant,
        suffixIconColor: cs.onSurfaceVariant,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: AppRadius.borderRadiusXl,
          borderSide: BorderSide(color: cs.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderRadiusXl,
          borderSide: BorderSide(color: cs.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderRadiusXl,
          borderSide: BorderSide(color: cs.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderRadiusXl,
          borderSide: BorderSide(color: cs.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderRadiusXl,
          borderSide: BorderSide(color: cs.error, width: 2),
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: cs.surfaceContainerHighest,
        selectedColor: cs.secondaryContainer,
        checkmarkColor: cs.onSecondaryContainer,
        side: BorderSide(color: cs.outlineVariant),
        labelStyle: TextStyle(
            color: cs.onSurface,
            fontSize: 13,
            fontWeight: FontWeight.w500),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        showCheckmark: false,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusLg),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: cs.inverseSurface,
        contentTextStyle: TextStyle(color: cs.onInverseSurface),
        actionTextColor: cs.inversePrimary,
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusMd),
      ),

      drawerTheme: DrawerThemeData(
        backgroundColor: cs.surface,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: AppRadius.card, bottomRight: AppRadius.card),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: cs.primary,
          foregroundColor: cs.onPrimary,
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusCard),
          elevation: 0,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: cs.primary,
          side: BorderSide(color: cs.outline),
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusCard),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: cs.primary,
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusCard),
        ),
      ),

      textTheme: TextTheme(
        headlineLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: cs.onSurface,
            height: 1.5),
        headlineMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: cs.onSurface,
            height: 1.5),
        titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: cs.onSurface,
            height: 1.5),
        titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: cs.onSurface,
            height: 1.5),
        titleSmall: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: cs.onSurface,
            height: 1.5),
        bodyLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: cs.onSurface,
            height: 1.5),
        bodyMedium: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: cs.onSurfaceVariant,
            height: 1.5),
        bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: cs.onSurfaceVariant,
            height: 1.5),
        labelSmall: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: cs.onSurfaceVariant),
      ),
    );
  }

  static ThemeData dark() {
    const cs = AppColorsDark.scheme;
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColorsDark.scheme,
      extensions: [PaletteExtension.dark()],
      scaffoldBackgroundColor: cs.surface,

      cardTheme: CardThemeData(
        color: cs.surfaceContainer,
        elevation: 0,
        shadowColor: cs.shadow.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.borderRadiusCard,
          side: BorderSide(color: cs.outlineVariant),
        ),
        margin: EdgeInsets.zero,
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: cs.surfaceContainerLow,
        indicatorColor: cs.primary.withValues(alpha: 0.15),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return IconThemeData(color: cs.primary);
          return IconThemeData(color: cs.onSurfaceVariant);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: cs.primary);
          return TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: cs.onSurfaceVariant
            );
        }),
      ),

      dividerTheme: DividerThemeData(color: cs.outlineVariant, thickness: 1),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cs.surfaceContainerHigh,
        hintStyle: TextStyle(color: cs.onSurfaceVariant.withValues(alpha: 0.7)),
        prefixIconColor: cs.onSurfaceVariant,
        suffixIconColor: cs.onSurfaceVariant,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: AppRadius.borderRadiusXl,
          borderSide: BorderSide(color: cs.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderRadiusXl,
          borderSide: BorderSide(color: cs.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderRadiusXl,
          borderSide: BorderSide(color: cs.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderRadiusXl,
          borderSide: BorderSide(color: cs.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderRadiusXl,
          borderSide: BorderSide(color: cs.error, width: 2),
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: cs.surfaceContainerHigh,
        selectedColor: cs.secondaryContainer,
        checkmarkColor: cs.onSecondaryContainer,
        side: BorderSide(color: cs.outlineVariant),
        labelStyle: TextStyle(
            color: cs.onSurface,
            fontSize: 13,
            fontWeight: FontWeight.w500),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        showCheckmark: false,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusLg),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: cs.inverseSurface,
        contentTextStyle: TextStyle(color: cs.onInverseSurface),
        actionTextColor: cs.inversePrimary,
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusMd),
      ),

      drawerTheme: DrawerThemeData(
        backgroundColor: cs.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: AppRadius.card, bottomRight: AppRadius.card),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: cs.primary,
          foregroundColor: cs.onPrimary,
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusCard),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: cs.primary,
          side: BorderSide(color: cs.outline),
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusCard),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: cs.primary,
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusCard),
        ),
      ),

      textTheme: TextTheme(
        headlineLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: cs.onSurface,
            height: 1.5),
        headlineMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: cs.onSurface,
            height: 1.5),
        titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: cs.onSurface,
            height: 1.5),
        titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: cs.onSurface,
            height: 1.5),
        bodyLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: cs.onSurface,
            height: 1.5),
        bodyMedium: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: cs.onSurfaceVariant,
            height: 1.5),
        bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: cs.onSurfaceVariant,
            height: 1.5),
        labelSmall: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: cs.onSurfaceVariant),
      ),
    );
  }
}