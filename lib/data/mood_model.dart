import 'package:flutter/material.dart';
import 'package:project_azkar/utils/enums.dart';

class MoodModel {
  final String header;
  final String title;
  final String subtitle;
  final Categories category;
  final ColorPalette colorPalette;
  final IconData icon;

  MoodModel({
    required this.header,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.colorPalette,
    required this.icon,
  });
}

class ColorPalette {
  final Color mainColor;
  final Color backgroundColor;
  final Color badgeTextColor;
  final Color borderColor;
  final Color cardBottomColor;
  final Color cardBackgroundColor;

  ColorPalette({
    required this.mainColor,
    required this.backgroundColor,
    required this.badgeTextColor,
    required this.borderColor,
    required this.cardBottomColor,
    required this.cardBackgroundColor,
  });
}
