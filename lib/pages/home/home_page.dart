import 'package:flutter/material.dart';
import 'package:project_azkar/pages/home/widgets/mood_container.dart';

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
              itemCount: moodItems.length,
              separatorBuilder: (context, index) => SizedBox(width: 16),
              itemBuilder: (context, index) => moodItems[index],
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

final List<Widget> moodItems = [
  MoodContainer(
    'سعيد',
    iconData: Icons.sunny,
    iconColor: Color(0xFFF28512),
    // backgroundColor: Color(0xFF32281F),
  ),
  MoodContainer(
    'حزين',
    iconData: Icons.cloud_off_outlined,
    iconColor: Color(0xFF7B85FA), // HSL 234, 89, 74
    // backgroundColor: Color(0xFF1E202F), // HSL 233, 23, 15
  ),
  MoodContainer(
    'قلق',
    iconData: Icons.night_shelter,
    iconColor: Color(0xFF17CE55),
    // backgroundColor: Color(0xFF15281A),
  ),
  MoodContainer(
    'مريض',
    iconData: Icons.bed,
    iconColor: Color(0xFFB983FC),
    // backgroundColor: Color(0xFF211D2F),
  ),
];
