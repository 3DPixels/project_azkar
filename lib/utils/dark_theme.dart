import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkGreen,
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.darkerGreen,
      indicatorColor: Colors.green,
      iconTheme: WidgetStateProperty.all(
        const IconThemeData(color: Colors.white),
      ),
    ),
    colorScheme: ColorScheme.dark(
      // primary: AppColors.darkGreen,
      // secondary: AppColors.darkerGreen,
      // surface: AppColors.darkerGreen,
      // onSecondary: Colors.white,
    ),
    textTheme: GoogleFonts.ibmPlexSansArabicTextTheme(
      ThemeData(brightness: Brightness.dark).textTheme,
    ),
  );
}
