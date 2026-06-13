import 'package:flutter/material.dart';
import 'package:project_azkar/data/mood_model.dart';
import 'package:project_azkar/data/supplications_repo.dart';
import 'package:project_azkar/pages/mood_prayers/widgets/mood_prayer_card.dart';
import 'package:project_azkar/utils/formatters.dart';

class MoodDetails extends StatelessWidget {
  final MoodModel mood;

  const MoodDetails(this.mood, {super.key});

  @override
  Widget build(BuildContext context) {
    final supplications = SupplicationsRepo.getSupplicationByCategory(
      mood.category,
    );
    return Scaffold(
      backgroundColor: mood.colorPalette.backgroundColor,
      appBar: AppBar(
        backgroundColor: mood.colorPalette.backgroundColor.withValues(
          alpha: .95,
        ),
        centerTitle: true,
        title: Text('أدعية مختارة'),
        toolbarHeight: 73,
        leadingWidth: 64,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Title
            Container(
              height: 248,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentGeometry.topCenter,
                  end: AlignmentGeometry.bottomCenter,
                  colors: [
                    mood.colorPalette.mainColor.withValues(alpha: 0.10),
                    mood.colorPalette.mainColor.withValues(alpha: 0.00),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 12,
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: mood.colorPalette.mainColor.withValues(
                      alpha: .2,
                    ),
                    foregroundColor: mood.colorPalette.mainColor,
                    child: Icon(mood.icon, size: 48),
                  ),
                  // SizedBox(height: 10),
                  Text(
                    mood.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontFamily: 'NotoSansArabicVar',
                    ),
                  ),
                  // SizedBox(height: 10),
                  Text(
                    mood.subtitle,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontFamily: 'NotoSansArabicVar',
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: mood.colorPalette.mainColor.withValues(
                        alpha: 0.10,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                    child: Text(
                      '${supplications.length.toArabic()} دعاء',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: mood.colorPalette.badgeTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Body
            /// TODO change to list view builder and use custom scroll view with sliver appbar maybe
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                spacing: 16,
                children: supplications
                    .map(
                      (sup) => MoodPrayerCard(
                        supplication: sup,
                        buttonsColor: mood.colorPalette.mainColor,
                        borderColor: mood.colorPalette.borderColor,
                        bottomColor: mood.colorPalette.cardBottomColor,
                        containerBackgroundColor:
                            mood.colorPalette.cardBackgroundColor,
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
