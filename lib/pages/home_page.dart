import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_azkar/providers/settings_cubit/settings_cubit.dart';
import 'package:project_azkar/utils/app_colors.dart';

import '../data/zekr_model.dart';
import 'azkar_page.dart';

int count = 45;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        Row(
          children: [
            Text('السلام عليكم', style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        // Prayer card
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.darkGradient, AppColors.darkGreen],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            spacing: 20,
            children: [
              // First row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    spacing: 5,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on),
                          Text('القاهرة، مصر'),
                        ],
                      ),
                      Text(
                        'صلاة العصر',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white.withValues(alpha: 0.1),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Column(
                      children: [Text('الصلاة القادمة'), Text('03:45')],
                    ),
                  ),
                ],
              ),
              // Second row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('المتبقي حتى الأذان'),
                      Text('00:$count:23'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

extension ArabicNumberConverter on int {
  String toArabicDigits() {
    const englishDigits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    String input = toString();
    for (int i = 0; i < englishDigits.length; i++) {
      input = input.replaceAll(englishDigits[i], arabicDigits[i]);
    }
    return input;
  }
}
