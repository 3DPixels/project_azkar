import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_azkar/data/repos/mood_repo.dart';
import 'package:project_azkar/widgets/mood_container.dart';

import '../../cubits/prayer_cubit/prayer_cubit.dart';
import '../supplications/moods/moods_list.dart';
import 'home_azkar_grid.dart';
import '../../widgets/summary_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 18,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'السلام عليكم',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                BlocBuilder<PrayerCubit, PrayerState>(
                  builder: (context, state) {
                    if (state is PrayerLoaded) {
                      return Text(
                        state.hijriDate,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: const Color(0xFFA0A0A0),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
          // Prayer card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SummaryCard(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'بماذا تشعر اليوم؟',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                // TextButton(child: Text('عرض الكل'), onPressed: () {}),
              ],
            ),
          ),
          // Moods
          SizedBox(
            height: 92,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: MoodRepo.allMoods.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              separatorBuilder: (context, index) => SizedBox(width: 16),
              itemBuilder: (context, index) {
                final mood = MoodRepo.allMoods[index];
                return MoodContainer(
                  title: mood.header,
                  iconData: mood.icon,
                  iconColor: mood.colorPalette.mainColor,
                  detailsPage: MoodsList(mood),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'الأذكار اليومية',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: HomeAzkarGrid(),
          ),
        ],
      ),
    );
  }
}
