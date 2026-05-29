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
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.dsNeutral,
      ),
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
