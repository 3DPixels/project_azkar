import 'package:flutter/material.dart';

import '../../utils/styles.dart';

class PrayersGrid extends StatelessWidget {
  const PrayersGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
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
        // color: AppColors.darkSectionBackground,
        borderRadius: BorderRadius.circular(16),
        border: BoxBorder.all(color: Color(0xFF2D2D2D)),
      ),
      // padding: EdgeInsets.symmetric(vertical: 26, horizontal: 35),
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            // backgroundColor: AppColors.primaryAccent2,
            radius: 28,
            child: Icon(
              Icons.nights_stay_outlined,
              // color: AppColors.primaryAccent,
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
            ).textTheme.bodySmall?.copyWith(color: Color(0xFF9CA3AF)),
          ),
        ],
      ),
    );
  }
}
