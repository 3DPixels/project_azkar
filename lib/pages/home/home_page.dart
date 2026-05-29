import 'package:flutter/material.dart';
import 'package:project_azkar/data/mood_repo.dart';
import 'package:project_azkar/pages/home/widgets/mood_container.dart';

import '../mood_prayers/mood_details.dart';
import 'home_azkar_grid.dart';
import 'summary_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'السلام عليكم',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                'ربيع الاول، 1447',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.white70),
              ),
            ],
          ),
          // Prayer card
          SummaryCard(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'بماذا تشعر اليوم؟',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(child: Text('عرض الكل'), onPressed: () {}),
            ],
          ),
          // Moods
          SizedBox(
            height: 92,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: MoodRepo.allMoods.length,
              separatorBuilder: (context, index) => SizedBox(width: 16),
              itemBuilder: (context, index) {
                final mood = MoodRepo.allMoods[index];
                return MoodContainer(
                  title: mood.header,
                  iconData: mood.icon,
                  iconColor: mood.colorPalette.mainColor,
                  detailsPage: MoodDetails(mood),
                );
              },
            ),
          ),
          Text(
            'الأذكار اليومية',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          HomeAzkarGrid(),
        ],
      ),
    );
  }
}
