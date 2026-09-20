import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkPageBG,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      surface: AppColors.darkGreenSurface,
      // outline: AppColors.darkGreenBorder,
    ),
    fontFamily: AppFonts.ibmPlex,
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
    // navigationBarTheme: NavigationBarThemeData(
    //   backgroundColor: AppColors.darkGreenNavBarBG,
    //   // indicatorColor: AppColors.primary.withAlpha(100), // Toned down primary
    //   // iconTheme: WidgetStateProperty.all(
    //   //   const IconThemeData(color: Colors.white),
    //   // ),
    // ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: SharedAxisPageTransitionsBuilder(
          transitionType: SharedAxisTransitionType.scaled,
          fillColor: Colors.transparent,
        ),
      },
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      dragHandleColor: Color.fromARGB(70, 255, 255, 255),
      dragHandleSize: Size(60, 5),
    ),
  );
}
