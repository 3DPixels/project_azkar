import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/cache_service.dart';
import '../../services/location_service.dart';
import '../../services/prayer_service.dart';

part 'prayer_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  final LocationService locationService;
  final PrayerService prayerService;

  PrayerCubit(this.locationService, this.prayerService)
    : super(PrayerInitial());

  // Default Cairo coordinates fallback
  static const double defaultLat = 30.0444;
  static const double defaultLng = 31.2357;
  static const String defaultCity = 'القاهرة، مصر';

  Future<void> initPrayerTimes() async {
    emit(PrayerLoading());

    // 1. Try Cache First
    // 1. Try Cache First directly from CacheService
    final cached = CacheService.getCachedLocation();
    if (cached != null) {
      _emitLoadedState(cached['lat'], cached['lng'], cached['city']);
    }

    // 2. Check Permissions
    final permStatus = await locationService.checkPermissionStatus();

    if (permStatus == LocationPermissionResult.granted) {
      await _fetchAndEmitFreshLocation();
    } else if (permStatus == LocationPermissionResult.denied) {
      // Pass the flag to the loaded state so the UI draws the fallback AND shows the dialog
      _emitLoadedState(
        cached?['lat'] ?? defaultLat,
        cached?['lng'] ?? defaultLng,
        cached?['city'] ?? defaultCity,
        showPermissionDialog: true,
      );
    } else {
      // Permanently denied or service disabled -> Fallback to cache or default
      if (cached == null) {
        _emitLoadedState(
          defaultLat,
          defaultLng,
          defaultCity,
          showPermissionDialog: true,
        );
      }
    }
  }

  Future<void> requestLocationAndFetch() async {
    final result = await locationService.requestPermission();
    if (result == LocationPermissionResult.granted) {
      await _fetchAndEmitFreshLocation();
    } else {
      // User still denied -> Stick with current cache or fallback
      final cached = CacheService.getCachedLocation();
      _emitLoadedState(
        cached?['lat'] ?? defaultLat,
        cached?['lng'] ?? defaultLng,
        cached?['city'] ?? defaultCity,
      );
    }
  }

  Future<void> _fetchAndEmitFreshLocation() async {
    try {
      final fresh = await locationService.fetchLocation();
      _emitLoadedState(fresh['lat'], fresh['lng'], fresh['city']);
    } catch (e) {
      if (state is! PrayerLoaded) {
        _emitLoadedState(defaultLat, defaultLng, defaultCity);
      }
    }
  }

  void _emitLoadedState(
    double lat,
    double lng,
    String city, {
    bool showPermissionDialog = false,
  }) {
    final hijri = prayerService.getFormattedHijriDate();
    final data = prayerService.getTodayPrayerData(lat, lng);

    emit(
      PrayerLoaded(
        locationName: city,
        hijriDate: hijri,
        prayers: data['prayers'] as List<Map<String, dynamic>>,
        currentOrNextPrayerTitle: data['currentOrNextPrayerTitle'] as String,
        nextPrayerDateTime: data['nextPrayerDateTime'] as DateTime?,
      ),
    );
  }
}
