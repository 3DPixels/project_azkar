import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary, // orange "Primary"
      onPrimary: Colors.white, // Text on top of orange buttons
      secondary: AppColors.accent, // brown "Accent"
      onSecondary: Colors.white, // Text on top of brown elements
      surface: AppColors.lightSurfaceBackground,
      onSurface: Colors.black, // Text on cards, etc.
    ),
    // textTheme: GoogleFonts.readexProTextTheme(),
  );
}
