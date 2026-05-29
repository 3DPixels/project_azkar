import 'package:flutter/material.dart';
import 'package:project_azkar/data/mood_model.dart';
import 'package:project_azkar/utils/enums.dart';

class MoodRepo {
  static final List<MoodModel> allMoods = [
    MoodModel(
      header: 'حزين',
      title: 'عند الشعور بالحزن',
      subtitle: 'أدعية للصبر و السكينة',
      category: Categories.sad,
      icon: Icons.cloud_off_outlined,
      colorPalette: ColorPalette(
        mainColor: Color(0xFF2B6CEE),
        backgroundColor: Color(0xFF101622),
        badgeTextColor: Color(0xFF93C5FD),
        borderColor: Color(0xFF1E293B),
        cardBottomColor: Color(0xFF151A23),
        cardBackgroundColor: Color(0xFF1A202C),
      ),
    ),
    MoodModel(
      header: 'مظلوم',
      title: 'عند التعرض للظلم',
      subtitle: 'أدعية النصر والتوكل على عدل الله',
      category: .oppressed,
      icon: Icons.balance,
      colorPalette: ColorPalette(
        mainColor: Color(0xFFB8860B),
        backgroundColor: Color(0xFF161412),
        badgeTextColor: Color(0xFFD4AF37),
        borderColor: Color(0xFFB8860B).withValues(alpha: .1),
        cardBottomColor: Color(0xFF13110F),
        cardBackgroundColor: Color(0xFF1C1815),
      ),
    ),
    MoodModel(
      header: 'مقصر',
      title: 'التقصير والشعور بالذنب',
      subtitle: 'أدعية للاستغفار والتوبة',
      category: .negligent,
      icon: Icons.device_thermostat_outlined,
      colorPalette: ColorPalette(
        mainColor: Color(0xFF84CC16),
        backgroundColor: Color(0xFF121412),
        badgeTextColor: Color(0xFF65A30D),
        borderColor: Color(0xFF365314).withValues(alpha: .2),
        cardBottomColor: Color(0xFF141714),
        cardBackgroundColor: Color(0xFF191C19),
      ),
    ),
    MoodModel(
      header: 'الضيق',
      title: 'الضيق الشديد',
      subtitle: 'أدعية للفرج والصبر واللجوء إلى الله',
      category: .helpless,
      icon: Icons.device_thermostat_outlined,
      colorPalette: ColorPalette(
        mainColor: Color(0xFFE11D48),
        backgroundColor: Color(0xFF181412),
        badgeTextColor: Color(0xFFFB7185),
        borderColor: Color(0xFF7F1D1D).withValues(alpha: .2),
        cardBottomColor: Color(0xFF151110),
        cardBackgroundColor: Color(0xFF1E1917),
      ),
    ),
  ];
}
