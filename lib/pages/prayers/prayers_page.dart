import 'package:flutter/material.dart';

import 'carousel_prayers.dart';
import 'prayers_grid.dart';

class PrayersPage extends StatelessWidget {
  const PrayersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('أدعية و مناسبات خاصة', style: TextStyle()),
        Text('الأكثر تكرارا'),
        CarouselExample(),
        Text('القائمة الكاملة'),
        PrayersGrid(),
      ],
    );
  }
}
