import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

ThemeData darkTheme() {
  return ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      // primary colors
      primary: AppColors.primary, // orange "Primary"
      onPrimary: Colors.white,
      // primaryContainer: const Color(0xFF6F430A), // A darker, muted orange
      // onPrimaryContainer: Colors.white,

      // secondary colors
      secondary: AppColors.accent, // brown "Accent"
      onSecondary: Colors.white,
      // secondaryContainer: const Color(0xFF312523), // A darker, muted brown
      // onSecondaryContainer: Colors.white,

      // Tertiary color - re-using the accent color is a safe choice
      // tertiary: AppColors.accent,
      // onTertiary: Colors.white,

      // background colors
      surface: AppColors.darkBackground,
      onSurface: Colors.white,

      // Variant colors for things like outlines or subdued text
      // onSurfaceVariant: Colors.white.withValues(alpha: 0.7),
      // outline: Colors.white.withValues(alpha: 0.5),
    ),
    textTheme: GoogleFonts.readexProTextTheme(
      ThemeData(brightness: Brightness.dark).textTheme,
    ),
  );
}
