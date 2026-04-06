import 'package:flutter/material.dart';

class HomeAzkarGrid extends StatelessWidget {
  const HomeAzkarGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Text('الأذكار اليومية'),
          // To make an orange one (like your image)
          Expanded(
            child: Row(
              spacing: 16,
              children: [
                Expanded(
                  child: DynamicGlowCard(
                    seedColor: Colors.orange,
                    title: 'أذكار الصباح',
                    subtitle: 'بداية يوم مبارك',
                    icon: Icons.wb_sunny,
                  ),
                ),

                // To make a blue one
                Expanded(
                  child: DynamicGlowCard(
                    seedColor: Colors.blueAccent,
                    title: 'أذكار المساء', // Evening Azkar
                    subtitle: 'نهاية يوم هادئة',
                    icon: Icons.nights_stay,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              spacing: 16,
              children: [
                Expanded(
                  child: DynamicGlowCard(
                    seedColor: Colors.green,
                    title: 'أذكار بعد الصلاة',
                    subtitle: 'ختام الصلاة',
                    icon: Icons.night_shelter,
                  ),
                ),

                // To make a blue one
                Expanded(
                  child: DynamicGlowCard(
                    seedColor: Colors.purple,
                    title: 'أذكار النوم', // Evening Azkar
                    subtitle: 'ختام اليوم',
                    icon: Icons.bed,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DynamicGlowCard extends StatelessWidget {
  final Color seedColor;
  final String title;
  final String subtitle;
  final IconData icon;

  const DynamicGlowCard({
    super.key,
    required this.seedColor,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Convert the seed color to HSL
    final hslColor = HSLColor.fromColor(seedColor);

    // 2. Calculate the darker shades by reducing lightness (0.0 to 1.0)
    // Clamp ensures we don't drop below 0 (pure black)
    final glowColor = hslColor
        .withLightness((hslColor.lightness * 0.3).clamp(0.0, 1.0))
        .toColor();
    final bgColor = hslColor
        .withLightness((hslColor.lightness * 0.3).clamp(0.0, 1.0))
        .withSaturation(.5)
        .toColor();

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: RadialGradient(
          center: const Alignment(0.6, -0.6),
          radius: .7,
          colors: [bgColor, Color.fromARGB(250, 28, 38, 31)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 3,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: glowColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: seedColor, size: 24),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
