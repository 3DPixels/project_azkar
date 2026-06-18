import 'package:flutter/material.dart';
import 'package:project_azkar/utils/styles.dart';

import 'carousel_prayers.dart';
import 'prayers_grid.dart';

class PrayersPage extends StatelessWidget {
  const PrayersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'أدعية و مناسبات خاصة',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text('الأكثر تكرارا', style: Theme.of(context).textTheme.titleMedium),
        CarouselExample(),
        Text('القائمة الكاملة', style: Theme.of(context).textTheme.titleMedium),
        PrayersGrid(),
      ],
    );
  }
}
