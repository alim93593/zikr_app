import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Centralized typography for the Zikr app.
/// - Arabic display: Amiri (elegant calligraphic)
/// - UI titles and latin-friendly UI: Cairo (works well with Arabic and Latin scripts)
class AppTextStyles {
  AppTextStyles._();

  // Headline / Title - uses Cairo for good readability across UI languages
  static TextStyle get headline1 => GoogleFonts.cairo(
        color: AppColors.textPrimary,
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.2,
      );

  static TextStyle get headline2 => GoogleFonts.cairo(
        color: AppColors.textPrimary,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      );

  // Body text - Cairo
  static TextStyle get body1 => GoogleFonts.cairo(
        color: AppColors.textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get body2 => GoogleFonts.cairo(
        color: AppColors.textSecondary,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );

  // Arabic decorative / scripture style - Amiri
  static TextStyle get arabicDisplay => GoogleFonts.amiri(
        color: AppColors.textPrimary,
        fontSize: 26,
        fontWeight: FontWeight.w400,
        height: 1.35,
      );

  // Small captions
  static TextStyle get caption => GoogleFonts.cairo(
        color: AppColors.muted,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      );
}
