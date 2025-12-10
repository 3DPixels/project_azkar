import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.darkBackground),
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary, // orange "Primary"
      onPrimary: Colors.white, // Text on top of orange buttons
      secondary: AppColors.accent, // brown "Accent"
      onSecondary: Colors.white, // Text on top of brown elements
      surface: AppColors.darkSurfaceBackground,
      onSurface: Colors.white,
    ),
    // textTheme: GoogleFonts.readexProTextTheme(
    //   ThemeData(brightness: Brightness.dark).textTheme,
    // ),
  );
}
