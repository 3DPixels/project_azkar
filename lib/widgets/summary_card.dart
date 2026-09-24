import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_azkar/widgets/prayer_time.dart';
import 'package:project_azkar/widgets/time_remaining_container.dart';

import '../cubits/prayer_cubit/prayer_cubit.dart';
import '../utils/app_colors.dart';

class SummaryCard extends StatefulWidget {
  const SummaryCard({super.key});

  @override
  State<SummaryCard> createState() => _SummaryCardState();
}

class _SummaryCardState extends State<SummaryCard> {
  ScrollController? _scrollController;

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  void _scrollToCurrentPrayer(
    List<Map<String, dynamic>> prayers,
    double maxWidth,
  ) {
    int targetIndex = prayers.indexWhere(
      (p) => p['isCurrent'] == true || p['isNext'] == true,
    );
    if (targetIndex == -1) targetIndex = 0;

    const double itemWidth = 85.0;
    double centerOffset =
        (targetIndex * itemWidth) + (itemWidth / 2) - (maxWidth / 2);
    if (centerOffset < 0) centerOffset = 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController != null && _scrollController!.hasClients) {
        _scrollController!.animateTo(
          centerOffset,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else {
        _scrollController = ScrollController(initialScrollOffset: centerOffset);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //TODO maybe switch the outer container with material widget with these properties to get the elevation and shadow easily without needing to manage the box shadow manually
    /**
  color: const Color(0xFF1A2A1F), // Your solid base color goes here
  borderRadius: BorderRadius.circular(16),
  elevation: 4, // Bonus: Easily add shadows if your design needs them
     */
    return BlocConsumer<PrayerCubit, PrayerState>(
      listener: (context, state) {
        if (state is PrayerLoaded && state.showPermissionDialog) {
          _showPermissionDialog(context);
        }
      },
      builder: (context, state) {
        if (state is PrayerLoading || state is PrayerInitial) {
          return const SizedBox(
            height: 180,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is PrayerLoaded) {
          return Container(
            decoration: BoxDecoration(
              //TODO choose one of these two colors after testing them in the app
              // color: const Color(0xFF1A2A1F),
              color: const Color(0xFF1C261F),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              // padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red,
                gradient: LinearGradient(
                  colors: [
                    AppColors.darkGreenPageBG.withValues(alpha: .8),
                    AppColors.darkGreenPageBG.withValues(alpha: .4),
                    AppColors.darkGreenPageBG.withAlpha(0),
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
                spacing: 12,
                children: [
                  // First Row: Location, Hijri Date, Prayer Name, Countdown
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  state.locationName,
                                  style: Theme.of(context).textTheme.labelMedium
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                ),
                              ],
                            ),
                            Text(
                              state.hijriDate,
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(color: Colors.white70),
                            ),
                            Text(
                              state.currentOrNextPrayerTitle,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        TimeRemainingContainer(
                          targetTime: state.nextPrayerDateTime,
                          onTimerComplete: () {
                            // Instantly refresh prayers when the countdown finishes
                            context.read<PrayerCubit>().initPrayerTimes();
                          },
                        ),
                      ],
                    ),
                  ),

                  // Second Row: Horizontal Prayers List
                  LayoutBuilder(
                    builder: (context, constraints) {
                      _scrollToCurrentPrayer(
                        state.prayers,
                        constraints.maxWidth,
                      );

                      return SizedBox(
                        height: 90,
                        child: ListView.builder(
                          controller: _scrollController ??= ScrollController(),
                          scrollDirection: Axis.horizontal,
                          itemCount: state.prayers.length,
                          itemExtent: 85,
                          itemBuilder: (context, index) {
                            final item = state.prayers[index];
                            return PrayerTime(
                              prayer: item['title'],
                              prayerTime: item['timeStr'],
                              passed: item['isPassed'],
                              currentPrayer:
                                  item['isCurrent'] || item['isNext'],
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

void _showPermissionDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => AlertDialog(
      title: const Text('إذن الموقع مطلوب'),
      content: const Text(
        'يحتاج التطبيق إلى إذن تحديد الموقع لحساب أوقات الصلاة والقبلة بدقة الخاصة بمدينتك.',
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(dialogContext);
          },
          child: const Text('تجاهل (استخدام الموقع الافتراضي)'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(dialogContext);
            context.read<PrayerCubit>().requestLocationAndFetch();
          },
          child: const Text('السماح بالموقع'),
        ),
      ],
    ),
  );
}
