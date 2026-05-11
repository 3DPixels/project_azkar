import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class SummaryCard extends StatefulWidget {
  const SummaryCard({super.key});

  @override
  State<SummaryCard> createState() => _SummaryCardState();
}

class _SummaryCardState extends State<SummaryCard> {
  ScrollController? _scrollController;
  // Track the width so we only recalculate if the screen resizes
  double? _previousMaxWidth;

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.darkPageBackgroundLight,
            AppColors.darkPageBackground,
          ],
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
        spacing: 30,
        children: [
          // First row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      Text(
                        'القاهرة، مصر',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ],
                  ),
                  Text(
                    'صلاة العصر',
                    style: Theme.of(context).textTheme.headlineMedium,
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
                  spacing: 5,
                  children: [
                    Text(
                      'باقي على الأذان',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.white54),
                    ),
                    Text(
                      '00:03:45',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Second row
          LayoutBuilder(
            builder: (context, constraints) {
              if (_scrollController == null) {
                final int currentPrayerIndex = 3;
                final double itemWidth = 85.0;

                double centerOffset =
                    (currentPrayerIndex * itemWidth) +
                    (itemWidth / 2) -
                    (constraints.maxWidth / 2);

                centerOffset = centerOffset < 0 ? 0 : centerOffset;

                _scrollController = ScrollController(
                  initialScrollOffset: centerOffset,
                );
              }
              return SizedBox(
                height: 100,
                child: ListView(
                  controller: _scrollController,
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
                      currentPrayer: true,
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
              );
            },
          ),
        ],
      ),
    );
  }
}

class PrayerTime extends StatelessWidget {
  final bool passed;
  final bool currentPrayer;
  final String prayer;
  final String prayerTime;
  const PrayerTime({
    super.key,
    required this.passed,
    required this.prayer,
    required this.prayerTime,
    this.currentPrayer = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        CircleAvatar(
          backgroundColor: !currentPrayer
              ? Colors.transparent
              : Theme.of(context).colorScheme.secondary,
          foregroundColor: Theme.of(context).colorScheme.onSecondary,
          child: Icon(passed ? Icons.check_circle : Icons.check_circle_outline),
        ),
        Text(prayer),
        Text(prayerTime),
      ],
    );
  }
}
