import 'package:flutter/material.dart';
import 'package:project_azkar/utils/app_colors.dart';

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
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).cardColor,
            hintText: 'بحث عن عبادة',
            hintStyle: TextStyle(color: Color(0xFF949DAF)),
            prefix: Icon(Icons.search),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: AppColors.neutral.withValues(alpha: .5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.white54),
            ),
          ),
        ),
        Text('الأكثر تكرارا', style: Theme.of(context).textTheme.titleMedium),
        CarouselExample(),
        Text('القائمة الكاملة', style: Theme.of(context).textTheme.titleMedium),
        PrayersGrid(),
      ],
    );
  }
}
