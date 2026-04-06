import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    children: [Icon(Icons.location_on), Text('القاهرة، مصر')],
                  ),
                  Text(
                    'صلاة العصر',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  children: [Text('المتبقي حتى الأذان'), Text('00:03:45')],
                ),
              ),
            ],
          ),
          // Second row
          SizedBox(
            height: 70,
            child: ListView(
              scrollDirection: Axis.horizontal,
              itemExtent: 85,
              children: [
                PrayerTime(
                  passed: true,
                  prayer: 'صلاة الفجر',
                  prayerTime: '03:35',
                ),
                PrayerTime(
                  passed: true,
                  prayer: 'صلاة الشروق',
                  prayerTime: '03:45',
                ),
                PrayerTime(
                  passed: true,
                  prayer: 'صلاة الظهر',
                  prayerTime: '03:45',
                ),
                PrayerTime(
                  passed: false,
                  prayer: 'صلاة العصر',
                  prayerTime: '03:45',
                ),
                PrayerTime(
                  passed: false,
                  prayer: 'صلاة المغرب',
                  prayerTime: '03:45',
                ),
                PrayerTime(
                  passed: false,
                  prayer: 'صلاة العشاء',
                  prayerTime: '03:45',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PrayerTime extends StatelessWidget {
  final bool passed;
  final String prayer;
  final String prayerTime;
  const PrayerTime({
    super.key,
    required this.passed,
    required this.prayer,
    required this.prayerTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(passed ? Icons.check_circle : Icons.check_circle_outline),
        Text(prayer),
        Text(prayerTime),
      ],
    );
  }
}
