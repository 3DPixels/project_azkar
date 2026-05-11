import 'package:flutter/material.dart';

class CardPalette {
  final Color iconColor;
  final Color glowColor; // The icon container background
  final Color gradientColor; // The radial gradient start

  const CardPalette({
    required this.iconColor,
    required this.glowColor,
    required this.gradientColor,
  });
}

class HomeAzkarGrid extends StatelessWidget {
  const HomeAzkarGrid({super.key});
  // night prayers HSL Background gradient 208 20 17 100%
  // night prayers HSL Background 233 23 15 100%
  // night prayers HSL 234 89 74 100%
  // morning prayers HSL Background gradient 48 25 16 100%
  // morning prayers HSL Background 35 23 16 100%
  // morning prayers HSL 25 95 53 100%
  // sleep prayers HSL Background gradient 235 12 18 100%
  // sleep prayers HSL Background 263 23 15 100%
  // sleep prayers HSL 270 95 75 100%
  // salah prayers HSL Background gradient 139 34 16 100%
  // salah prayers HSL Background 142 30 12 100%
  // salah prayers HSL 140 80 45 100%
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> azkarCards = [
      {
        'title': 'أذكار الصباح',
        'subtitle': 'بداية يوم مبارك',
        'icon': Icons.wb_sunny,
        'palette': const CardPalette(
          iconColor: Color(0xFFF28512), // HSL 25, 95, 53
          glowColor: Color(0xFF32281F), // HSL 35, 23, 16
          gradientColor: Color(0xFF332F20), // HSL 48, 25, 16
        ),
      },
      {
        'title': 'أذكار المساء',
        'subtitle': 'نهاية يوم هادئة',
        'icon': Icons.nights_stay,
        'palette': const CardPalette(
          iconColor: Color(0xFF7B85FA), // HSL 234, 89, 74
          glowColor: Color(0xFF1E202F), // HSL 233, 23, 15
          gradientColor: Color(0xFF222834), // HSL 208, 20, 17
        ),
      },
      {
        'title': 'أذكار بعد الصلاة',
        'subtitle': 'ختام الصلاة',
        'icon': Icons.night_shelter,
        'palette': const CardPalette(
          iconColor: Color(0xFF17CE55), // HSL 140, 80, 45
          glowColor: Color(0xFF15281A), // HSL 142, 30, 12
          gradientColor: Color(0xFF1B3622), // HSL 139, 34, 16
        ),
      },
      {
        'title': 'أذكار النوم',
        'subtitle': 'ختام اليوم',
        'icon': Icons.bed,
        'palette': const CardPalette(
          iconColor: Color(0xFFB983FC), // HSL 270, 95, 75
          glowColor: Color(0xFF211D2F), // HSL 263, 23, 15
          gradientColor: Color(0xFF282833), // HSL 235, 12, 18
        ),
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 220,
        crossAxisSpacing: 16.0, // Horizontal space
        mainAxisSpacing: 16.0, // Vertical space
        mainAxisExtent: 160.0, // Fixed height so it doesn't stretch vertically
      ),

      itemCount: azkarCards.length,
      itemBuilder: (context, index) {
        final card = azkarCards[index];
        return DynamicGlowCard(
          palette: card['palette'],
          title: card['title'],
          subtitle: card['subtitle'],
          icon: card['icon'],
        );
      },
    );
  }
}

class DynamicGlowCard extends StatelessWidget {
  final CardPalette palette;
  final String title;
  final String subtitle;
  final IconData icon;

  const DynamicGlowCard({
    super.key,
    required this.palette,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Icon(icon, color: palette.iconColor, size: 24),
          ),
          SizedBox(height: 10),
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
