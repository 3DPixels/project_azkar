import 'package:flutter/material.dart';

import 'app_colors.dart';

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkPageBackground,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.dsPrimary,
      // onPrimary: Colors.black, // Black text/icons look better on bright green
      secondary: AppColors.dsSecondary,
      onSecondary: Colors.white,
      tertiary: AppColors.dsTertiary,
      surface: AppColors.darkSurface,
      outline: AppColors.dsNeutral, // Good for borders
    ),
    fontFamily: 'IbmPlexSansArabic',
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(fontSize: 12),
      bodyLarge: TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
      bodyMedium: TextStyle(fontSize: 12),
      bodySmall: TextStyle(fontSize: 10),
    ).apply(bodyColor: Colors.white, displayColor: Colors.white),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.darkNavBarBackground,
      // indicatorColor: AppColors.dsPrimary.withAlpha(100), // Toned down primary
      // iconTheme: WidgetStateProperty.all(
      //   const IconThemeData(color: Colors.white),
      // ),
    ),
  );
}
