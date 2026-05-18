import 'package:flutter/material.dart';

import 'home_azkar_grid.dart';
import 'summary_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      child: SingleChildScrollView(
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
      ),
    );
  }
}

final List<Widget> moodItems = [
  MoodContainer('سعيد', iconData: Icons.sunny, iconColor: Colors.orange),
  MoodContainer(
    'حزين',
    iconData: Icons.cloud_off_outlined,
    iconColor: Colors.blueAccent,
  ),
  MoodContainer('قلق'),
  MoodContainer('مريض'),
  MoodContainer('مريض'),
  MoodContainer('مريض'),
  MoodContainer('مريض'),
  MoodContainer('مريض'),
  MoodContainer('مريض'),
  MoodContainer('مريض'),
  MoodContainer('مريض'),
];

class MoodContainer extends StatelessWidget {
  final String title;
  final IconData? iconData;
  final Color? iconColor;
  const MoodContainer(this.title, {super.key, this.iconData, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
          ),
          child: iconData != null ? Icon(iconData, color: iconColor) : Text(''),
        ),
        Text(title),
      ],
    );
  }
}
