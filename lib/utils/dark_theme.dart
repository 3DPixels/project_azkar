import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

ThemeData darkTheme() {
  // Base dark theme to inherit default text colors
  final baseDarkTheme = ThemeData(brightness: Brightness.dark);
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
    textTheme: GoogleFonts.ibmPlexSansArabicTextTheme(baseDarkTheme.textTheme),

    /// replace this text theme with the one above when font is downloaded locally and remove the [baseDarkTheme] variable
    ///
    // fontFamily: 'IbmPlexSansArabic', // Once added locally
    // textTheme: const TextTheme(
    //   // Equivalent to old 'titleStyle'
    //   titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    //
    //   // Equivalent to old 'headerStyle'
    //   titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //
    //   // Equivalent to old 'cardTitleStyle'
    //   titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    //
    //   // Equivalent to old 'bodyStyle'
    //   bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.dsNeutral),
    // ).apply(
    //   bodyColor: Colors.white,
    //   displayColor: Colors.white,
    // ),
    ///
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.darkNavBarBackground,
      // indicatorColor: AppColors.dsPrimary.withAlpha(100), // Toned down primary
      // iconTheme: WidgetStateProperty.all(
      //   const IconThemeData(color: Colors.white),
      // ),
    ),
  );
}
