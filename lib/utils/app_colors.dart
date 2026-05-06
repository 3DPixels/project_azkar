import 'dart:ui';

abstract class AppColors {
  static const Color darkGreen = Color(0xFF112116);
  static const Color darkerGreen = Color(0xFF111813);
  static const Color darkGradient = Color(0xFF273227);

  static const Color primary = Color(0xFFF59115); // Orange
  static const Color accent = Color(0xFF46332E); // Dark Brown

  static const Color darkBackground = Color.fromARGB(255, 20, 20, 20);
  // A deep charcoal/black for maximum focus
  static const Color darkBackground2 = Color(0xFF121212);
  // Dark gray cards to create depth
  static const Color darkSectionBackground = Color(0xFF1E1E1E);
  // Emerald Green used for key icons and call-to-action highlights
  static const Color primaryAccent = Color(0xFF586C42);
  static const Color primaryAccent2 = Color(0x10586C42);
  // Soft gray for descriptions and secondary info
  static const Color secondaryText = Color(0xFFA0A0A0);
  static const Color darkSurfaceBackground = Color(0xFF1D1D1D);
  static const Color lightSurfaceBackground = Color(0xFFEDEDED);
}
