import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static final ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: Colors.white,
    secondary: AppColors.secondary,
    onSecondary: Colors.white,
    error: AppColors.error,
    onError: Colors.white,
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
  );

  static final ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primaryVariant,
    onPrimary: Colors.white,
    secondary: AppColors.secondaryVariant,
    onSecondary: Colors.black,
    error: AppColors.error,
    onError: Colors.black,
    surface: const Color(0xFF0F1724),
    onSurface: Colors.white,
  );

  static ThemeData get light {
    return ThemeData(
      colorScheme: _lightColorScheme,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: _lightColorScheme.primary,
      canvasColor: AppColors.background,
      cardColor: _lightColorScheme.surface,
      dividerColor: AppColors.divider,
      textTheme: TextTheme(
        displayLarge: AppTextStyles.headline1,
        displayMedium: AppTextStyles.headline2,
        bodyLarge: AppTextStyles.body1,
        bodyMedium: AppTextStyles.body2,
        labelSmall: AppTextStyles.caption,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: _lightColorScheme.onSurface,
        elevation: 0,
        iconTheme: IconThemeData(color: _lightColorScheme.primary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _lightColorScheme.primary,
          foregroundColor: _lightColorScheme.onPrimary,
          textStyle: AppTextStyles.body1.copyWith(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      useMaterial3: true,
    );
  }

  static ThemeData get dark {
    return ThemeData(
      colorScheme: _darkColorScheme,
      scaffoldBackgroundColor: _darkColorScheme.surface,
      primaryColor: _darkColorScheme.primary,
      canvasColor: _darkColorScheme.surface,
      cardColor: _darkColorScheme.surface,
      dividerColor: Colors.transparent,
      textTheme: TextTheme(
        displayLarge: AppTextStyles.headline1.copyWith(color: Colors.white),
        displayMedium: AppTextStyles.headline2.copyWith(color: Colors.white),
        bodyLarge: AppTextStyles.body1.copyWith(color: Colors.white),
        bodyMedium: AppTextStyles.body2.copyWith(color: Colors.white70),
        labelSmall: AppTextStyles.caption.copyWith(color: Colors.white60),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: _darkColorScheme.surface,
        foregroundColor: _darkColorScheme.onSurface,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _darkColorScheme.primary,
          foregroundColor: _darkColorScheme.onPrimary,
          textStyle: AppTextStyles.body1.copyWith(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _darkColorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      useMaterial3: true,
    );
  }
}
