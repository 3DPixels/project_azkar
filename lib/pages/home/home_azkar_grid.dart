import 'package:flutter/material.dart';
import 'package:project_azkar/data/zekr_repo.dart';
import 'package:project_azkar/pages/supplications/azkar/azkar_page.dart';
import 'package:project_azkar/utils/enums.dart';

import '../../data/card_pallete_model.dart';
import '../../widgets/gradient_card.dart';

class AzkarCardData {
  final String title;
  final String subtitle;
  final IconData icon;
  final CardPalette palette;
  final DuaTime duaTime; // Added your enum here!

  const AzkarCardData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.palette,
    required this.duaTime,
  });
}

final List<AzkarCardData> azkarCards = [
  AzkarCardData(
    title: 'أذكار الصباح',
    subtitle: 'بداية يوم مبارك',
    icon: Icons.wb_sunny,
    palette: const CardPalette(
      iconColor: Color(0xFFF28512),
      glowColor: Color(0xFF32281F),
      gradientColor: Color(0xFF332F20),
    ),
    duaTime: DuaTime.day, // Replace with your actual enum value
  ),
  AzkarCardData(
    title: 'أذكار المساء',
    subtitle: 'نهاية يوم هادئة',
    icon: Icons.nights_stay,
    palette: const CardPalette(
      iconColor: Color(0xFF7B85FA),
      glowColor: Color(0xFF1E202F),
      gradientColor: Color(0xFF222834),
    ),
    duaTime: DuaTime.night, // Replace with your actual enum value
  ),
  AzkarCardData(
    title: 'أذكار بعد الصلاة',
    subtitle: 'ختام الصلاة',
    icon: Icons.night_shelter,
    palette: const CardPalette(
      iconColor: Color(0xFF17CE55),
      glowColor: Color(0xFF15281A),
      gradientColor: Color(0xFF1B3622),
    ),
    duaTime: DuaTime.afterPrayer, // Replace with your actual enum value
  ),
  AzkarCardData(
    title: 'أذكار قبل النوم',
    subtitle: 'ختام اليوم',
    icon: Icons.bed,
    palette: const CardPalette(
      iconColor: Color(0xFFB983FC),
      glowColor: Color(0xFF211D2F),
      gradientColor: Color(0xFF282833),
    ),
    duaTime: DuaTime.beforeSleep, // Replace with your actual enum value
  ),
];

class HomeAzkarGrid extends StatelessWidget {
  const HomeAzkarGrid({super.key});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 1.3,
      ),
      itemCount: azkarCards.length,
      itemBuilder: (context, index) {
        final card = azkarCards[index];
        return GradientCard(
          palette: card.palette,
          title: card.title,
          subtitle: card.subtitle,
          icon: card.icon,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AzkarPage(
                  allSupplications: ZekrRepository.getAzkarByTime(card.duaTime),
                  title: card.title,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
