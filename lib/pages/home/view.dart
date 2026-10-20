import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_azkar/data/repos/mood_repo.dart';
import 'package:project_azkar/widgets/mood_container.dart';
import 'package:project_azkar/widgets/offline_banner.dart';
import 'package:project_azkar/widgets/permission_dialog.dart';

import '../../cubits/prayer_times_cubit.dart';
import '../../cubits/settings_cubit.dart';
import '../../extensions/date_time_extnesions.dart';
import '../../widgets/prayer_time.dart';
import '../../widgets/time_remaining_container.dart';
import '../supplications/moods/moods_list.dart';
import 'home_azkar_grid.dart';
import '../../widgets/summary_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PrayerTimesCubit, PrayerTimesState>(
          listenWhen: (previous, current) =>
              previous.locationStatus != current.locationStatus,
          listener: (context, state) {
            if (state.locationStatus == LocationStatus.serviceDisabled) {
              PermissionDialog.show(
                context,
                title: 'خدمة الموقع معطلة',
                content: 'يرجى تفعيل خدمة الموقع.',
              );
            } else if (state.locationStatus ==
                LocationStatus.permissionDenied) {
              PermissionDialog.show(
                context,
                title: 'صلاحية مطلوبة',
                content: 'التطبيق يحتاج إلى صلاحية الموقع.',
              );
            } else if (state.locationStatus ==
                LocationStatus.permissionPermanentlyDenied) {
              PermissionDialog.show(
                context,
                title: 'صلاحية مرفوضة نهائياً',
                content: 'التطبيق لا يعمل بدون صلاحية الموقع.',
                isPermanent: true,
              );
            }
          },
        ),
        BlocListener<PrayerTimesCubit, PrayerTimesState>(
          listenWhen: (previous, current) {
            // Wait until location resolution has settled (avoiding initial & loading)
            final isCurrentResolved =
                current.locationStatus != LocationStatus.initial &&
                current.locationStatus != LocationStatus.loading;
            final wasPending =
                previous.locationStatus == LocationStatus.initial ||
                previous.locationStatus == LocationStatus.loading;

            final coordinatesChanged =
                previous.latitude != current.latitude ||
                previous.longitude != current.longitude;

            return isCurrentResolved && (wasPending || coordinatesChanged);
          },
          listener: (context, state) {
            context.read<SettingsCubit>().scheduleNotifications(
              lat: state.latitude,
              lng: state.longitude,
              country: state.country,
              force: state.isManualRefresh,
            );
          },
        ),
      ],
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              await context.read<PrayerTimesCubit>().refreshLocation();
            },
            builder:
                (
                  context,
                  refreshState,
                  pulledExtent,
                  refreshTriggerPullDistance,
                  refreshIndicatorExtent,
                ) {
                  Widget indicator;

                  switch (refreshState) {
                    case RefreshIndicatorMode.drag:
                      // User is pulling down, but hasn't pulled far enough to trigger
                      indicator = const Text(
                        "اسحب لتحديث الموقع",
                        style: TextStyle(color: Colors.white54),
                      );
                      break;
                    case RefreshIndicatorMode.armed:
                      // User pulled far enough, ready to release
                      indicator = const Text(
                        "أفلت للتحديث",
                        style: TextStyle(color: Colors.white),
                      );
                      break;
                    case RefreshIndicatorMode.refresh:
                    case RefreshIndicatorMode.done:
                      // The refresh function is running
                      indicator = Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "جاري تحديث الموقع...",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      );
                      break;
                    case RefreshIndicatorMode.inactive:
                      indicator = const SizedBox.shrink();
                      break;
                  }

                  return Container(
                    alignment: Alignment.center,
                    height:
                        pulledExtent, // Dynamically expands as the user pulls
                    child: indicator,
                  );
                },
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
              buildWhen: (previous, current) =>
                  previous.locationStatus != current.locationStatus,
              builder: (context, state) {
                final isOfflineOrFallback =
                    state.locationStatus == LocationStatus.serviceDisabled ||
                    state.locationStatus == LocationStatus.permissionDenied ||
                    state.locationStatus ==
                        LocationStatus.permissionPermanentlyDenied;
                if (isOfflineOrFallback) {
                  return const OfflineBanner();
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          // Prayer card
          SliverToBoxAdapter(child: SummaryCard()),
          const SliverToBoxAdapter(child: SizedBox(height: 18)),
          SliverToBoxAdapter(
            child: Padding(
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
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 18)),

          // Moods
          SliverToBoxAdapter(
            child: SizedBox(
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
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 18)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'الأذكار اليومية',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 18)),
          SliverPadding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
            sliver: HomeAzkarGrid(),
          ),
        ],
      ),
    );
  }
}

class SummaryCard3 extends StatefulWidget {
  const SummaryCard3({super.key});

  @override
  State<SummaryCard3> createState() => _SummaryCard3State();
}

class _SummaryCard3State extends State<SummaryCard3> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToCurrentPrayer(int index) {
    if (index == -1 || !_scrollController.hasClients) return;

    // Estimate width of a single item + spacing (approx 80px item + 16px padding)
    const double itemWidth = 96.0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      double screenWidth = MediaQuery.of(context).size.width;

      // Calculate offset to center the item
      double offset = (index * itemWidth) - (screenWidth / 2) + (itemWidth / 2);

      // Prevent scrolling past limits
      offset = offset.clamp(0.0, _scrollController.position.maxScrollExtent);

      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
      builder: (context, state) {
        if (state.currentPrayerIndex != -1) {
          _scrollToCurrentPrayer(state.currentPrayerIndex);
        }
        return Card(
          margin: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              spacing: 20,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: .start,
                  spacing: 10,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 6,
                        children: [
                          Row(
                            children: [
                              if (state.locationStatus ==
                                  LocationStatus.loading)
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: SizedBox(
                                    height: 12,
                                    width: 12,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              if (state.locationStatus !=
                                  LocationStatus.loading)
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  '${state.city}، ${state.country}',
                                  overflow: .ellipsis,
                                  maxLines: 2,
                                  style: Theme.of(context).textTheme.titleLarge
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          // Formatting source and permission status below the location
                          Text(
                            '(${state.locationSource}، ${state.locationMessage})',
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(color: Colors.white54),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            DateTime.now().toHijriString(),
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    if (state.locationStatus == LocationStatus.loading &&
                        state.timerTarget == null)
                      const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    else
                      TimeRemainingContainer(
                        targetTime: state.timerTarget,
                        isPostAdhan: state.isPostAdhan,
                        onTimerComplete: () {
                          // Re-trigger calculation to transition state
                          context.read<PrayerTimesCubit>().calculatePrayers();
                        },
                      ),
                  ],
                ),

                // Bottom section of card: Horizontal List
                if (state.prayers.isNotEmpty)
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.prayers.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 30),
                      itemBuilder: (context, index) {
                        final prayer = state.prayers[index];
                        return PrayerTime(
                          passed: prayer.isPassed,
                          currentPrayer: prayer.isCurrent,
                          prayer: prayer.name,
                          prayerTime: prayer.timeString,
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
