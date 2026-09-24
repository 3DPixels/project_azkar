import 'package:flutter/material.dart';

import 'carousel_prayers.dart';
import 'prayers_grid.dart';

class PrayersPage extends StatelessWidget {
  const PrayersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 18,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 16),
        //   child: TextField(
        //     onTapOutside: (event) => FocusScope.of(context).unfocus(),
        //     decoration: InputDecoration(
        //       filled: true,
        //       fillColor: AppColors.darkSurface,
        //       hintText: 'بحث عن عبادة',
        //       hintStyle: TextStyle(color: AppColors.hint),
        //       prefixIcon: Icon(Icons.search),
        //       contentPadding: EdgeInsets.symmetric(vertical: 10),
        //       enabledBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(16),
        //         borderSide: BorderSide(color: AppColors.darkBorder),
        //       ),
        //       focusedBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(16),
        //         borderSide: BorderSide(color: Colors.white54),
        //       ),
        //     ),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'الأكثر تكرارا',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        CarouselPrayers(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'القائمة الكاملة',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        PrayersGrid(),
      ],
    );
  }
}
