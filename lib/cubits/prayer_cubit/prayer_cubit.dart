import 'package:adhan/adhan.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/location_service.dart';
import '../../services/prayer_service.dart';

part 'prayer_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  final LocationService locationService;
  final PrayerService prayerService;

  PrayerCubit(this.locationService, this.prayerService)
    : super(PrayerInitial());

  Future<void> initPrayerTimes() async {
    emit(PrayerLoading());

    try {
      // 1. Instantly load from cache to prevent UI delay
      final cached = await locationService.getCachedLocation();
      if (cached != null) {
        _emitPrayerData(cached['lat'], cached['lng'], cached['city']);
      }

      // 2. Fetch fresh GPS coordinates in the background
      final fresh = await locationService.fetchFreshLocation();
      _emitPrayerData(fresh['lat'], fresh['lng'], fresh['city']);
    } catch (e) {
      // Only show error if we didn't already successfully load cached data
      if (state is! PrayerLoaded) {
        emit(PrayerError(e.toString()));
      }
    }
  }

  void _emitPrayerData(double lat, double lng, String city) {
    final hijri = prayerService.getFormattedHijriDate();
    final data = prayerService.getTodayPrayerData(lat, lng);

    emit(
      PrayerLoaded(
        locationName: city,
        hijriDate: hijri,
        prayers: data['prayers'] as List<Map<String, dynamic>>,
        currentOrNextPrayer: data['nextPrayer'] as Prayer,
        nextPrayerDateTime: data['nextPrayerDateTime'] as DateTime?,
      ),
    );
  }
}
