import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/models/card_pallete_model.dart';

class GradientCard extends StatelessWidget {
  final CardPalette palette;
  final String title;
  final String subtitle;
  final IconData? icon;
  final String? iconPath;
  final VoidCallback? onTap;

  const GradientCard({
    super.key,
    required this.palette,
    required this.title,
    required this.subtitle,
    this.icon,
    this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: RadialGradient(
            center: const Alignment(0.6, -0.6),
            radius: .7,
            colors: [
              palette.gradientColor,
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 3,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: palette.glowColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: icon != null
                  ? Icon(icon, color: palette.iconColor, size: 24)
                  : SvgPicture.asset(iconPath!, width: 24),
            ),
            SizedBox(height: 10),
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            Text(subtitle, style: TextStyle(color: Color(0xFF9CA3AF))),
          ],
        ),
      ),
    );
  }
}
