import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class PrayersGrid extends StatelessWidget {
  const PrayersGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        mainAxisExtent: 157,
        children: [
          PrayerCard(),
          PrayerCard(),
          PrayerCard(),
          PrayerCard(),
          PrayerCard(),
          PrayerCard(),
          PrayerCard(),
          PrayerCard(),
        ],
      ),
    );
  }
}

class PrayerCard extends StatelessWidget {
  const PrayerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(16),
        border: BoxBorder.all(color: AppColors.darkBorder),
      ),
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.accent.withValues(alpha: .1),
            radius: 28,
            child: Icon(
              Icons.nights_stay_outlined,
              color: AppColors.accent,
              size: 22,
            ),
          ),
          Text(
            'صلاة الاستخارة',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Text(
            'دعاء و توجية',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.hint),
          ),
        ],
      ),
    );
  }
}
