import 'package:flutter/material.dart';
import 'package:project_azkar/data/mood_model.dart';
import 'package:project_azkar/utils/app_colors.dart';

import 'home_azkar_grid.dart';
import 'summary_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 16,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'السلام عليكم',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text('ربيع الاول، 1447'),
            ],
          ),
          // Prayer card
          SummaryCard(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('بماذا تشعر اليوم؟'),
              Text('عرض الكل', style: TextStyle(color: Colors.green)),
            ],
          ),
          // Moods
          SizedBox(
            height: 85,
            child: ListView(
              scrollDirection: Axis.horizontal,
              itemExtent: 75,
              children: [
                MoodContainer(MoodModel(emoji: '😊', title: 'سعيد')),
                MoodContainer(MoodModel(emoji: '😢', title: 'حزين')),
                MoodContainer(MoodModel(emoji: '😟', title: 'قلق')),
                MoodContainer(MoodModel(emoji: '🤒', title: 'مريض')),
                MoodContainer(MoodModel(emoji: '🤒', title: 'مريض')),
                MoodContainer(MoodModel(emoji: '🤒', title: 'مريض')),
                MoodContainer(MoodModel(emoji: '🤒', title: 'مريض')),
                MoodContainer(MoodModel(emoji: '🤒', title: 'مريض')),
                MoodContainer(MoodModel(emoji: '🤒', title: 'مريض')),
                MoodContainer(MoodModel(emoji: '🤒', title: 'مريض')),
                MoodContainer(MoodModel(emoji: '🤒', title: 'مريض')),
              ],
            ),
          ),
          HomeAzkarGrid(),
        ],
      ),
    );
  }
}

class MoodContainer extends StatelessWidget {
  final MoodModel mood;
  const MoodContainer(this.mood, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.darkGradient,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(mood.emoji, style: TextStyle(fontSize: 25)),
        ),
        Text(mood.title),
      ],
    );
  }
}
