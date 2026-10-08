import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_azkar/data/models/adhan_model.dart';

import '../services/location_service.dart';

part 'adhan_state.dart';

class AdhanCubit extends Cubit<AdhanState> {
  final LocationService _locationService;
  final AdhanService _adhanService;

  AdhanCubit(this._locationService, this._adhanService)
    : super(const AdhanState()) {
    _initializeLocationFlow();
  }

  Future<void> _initializeLocationFlow() async {
    // 1. Load Cache Immediately
    final cached = CacheService.getCachedLocation();
    if (cached != null) {
      emit(
        state.copyWith(
          locationStatus: LocationStatus.initial,
          city: cached['city'],
          country: cached['country'],
          latitude: cached['lat'],
          longitude: cached['lng'],
          locationSource: 'من الذاكرة المؤقتة',
          locationMessage: 'جاري التحقق من الصلاحيات...',
        ),
      );
    } else {
      emit(
        state.copyWith(
          locationStatus: LocationStatus.initial,
          city: 'الرياض',
          country: 'السعودية',
          latitude: 24.7136,
          longitude: 46.6753,
          locationSource: 'الموقع الافتراضي',
          locationMessage: 'لا يوجد موقع محفوظ',
        ),
      );
    }
    calculatePrayers();

    // 2. Check Location Service
    bool serviceEnabled = await _locationService.isServiceEnabled();
    if (!serviceEnabled) {
      emit(
        state.copyWith(
          locationStatus: LocationStatus.serviceDisabled,
          locationMessage: 'خدمة الموقع معطلة',
        ),
      );
      return;
    }

    // 3. Check & Request Permissions
    LocationPermission permission = await _locationService.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _locationService.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(
          state.copyWith(
            locationStatus: LocationStatus.permissionDenied,
            locationMessage: 'تم رفض إذن الوصول للموقع',
          ),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      emit(
        state.copyWith(
          locationStatus: LocationStatus.permissionPermanentlyDenied,
          locationMessage: 'إذن الوصول للموقع مرفوض نهائياً',
        ),
      );
      return;
    }

    // 4. Allowed: Fetch Location in background & Update
    emit(
      state.copyWith(
        locationStatus: LocationStatus.loading,
        locationMessage: 'جاري تحديث الموقع...',
      ),
    );

    try {
      print('Fetching current position...');
      Position? position = await _locationService.getCurrentPosition();

      // Reverse Geocoding
      print(
        'Fetching placemark for coordinates: ${position.latitude}, ${position.longitude}',
      );
      Placemark? place = await _locationService.getPlacemark(
        position.latitude,
        position.longitude,
      );

      // Prefer locality (city) first, then administrativeArea (governorate)
      String city = place?.locality ?? place?.administrativeArea ?? 'غير معروف';

      city = city.replaceAll('محافظة', '').trim();

      // Clean up any stray commas or spaces left behind
      city = city.replaceAll(RegExp(r'^[,،\s]+|[,،\s]+$'), '');

      String country = place?.country ?? 'غير معروف';

      // Update Cache with both
      await CacheService.cacheLocation(
        position.latitude,
        position.longitude,
        city,
        country,
      );

      // 5. Final State Update
      emit(
        state.copyWith(
          locationStatus: LocationStatus.success,
          city: city,
          country: country,
          latitude: position.latitude,
          longitude: position.longitude,
          locationSource: 'الموقع الحالي (GPS)',
          locationMessage: 'الصلاحيات ممنوحة',
        ),
      );

      calculatePrayers();
    } catch (e) {
      emit(
        state.copyWith(
          locationStatus: LocationStatus.error,
          locationMessage: 'فشل في جلب الموقع بدقة',
        ),
      );
    }
  }

  void calculatePrayers() {
    final now = DateTime.now();
    final todayPrayers = _adhanService.getTodayPrayers(
      state.latitude,
      state.longitude,
      state.country,
    );

    final List<PrayerModel> allPrayers = [
      PrayerModel(
        name: 'صلاة الفجر',
        timeString: _adhanService.formatTime(todayPrayers.fajr),
        time: todayPrayers.fajr,
      ),
      PrayerModel(
        name: 'صلاة الشروق',
        timeString: _adhanService.formatTime(todayPrayers.sunrise),
        time: todayPrayers.sunrise,
      ),
      PrayerModel(
        name: 'صلاة الظهر',
        timeString: _adhanService.formatTime(todayPrayers.dhuhr),
        time: todayPrayers.dhuhr,
      ),
      PrayerModel(
        name: 'صلاة العصر',
        timeString: _adhanService.formatTime(todayPrayers.asr),
        time: todayPrayers.asr,
      ),
      PrayerModel(
        name: 'صلاة المغرب',
        timeString: _adhanService.formatTime(todayPrayers.maghrib),
        time: todayPrayers.maghrib,
      ),
      PrayerModel(
        name: 'صلاة العشاء',
        timeString: _adhanService.formatTime(todayPrayers.isha),
        time: todayPrayers.isha,
      ),
    ];

    Prayer currentPrayer = todayPrayers.currentPrayer();
    Prayer nextPrayer = todayPrayers.nextPrayer();

    bool isPostAdhan = false;
    DateTime? timerTarget;
    int activeListIndex = -1;
    String currentPrayerName = '';

    // Check Iqamah window (25 mins)
    if (currentPrayer != Prayer.none && currentPrayer != Prayer.sunrise) {
      final currentPrayerTime = todayPrayers.timeForPrayer(currentPrayer);
      if (currentPrayerTime != null &&
          now.difference(currentPrayerTime).inMinutes < 25) {
        isPostAdhan = true;
        timerTarget = currentPrayerTime;
        activeListIndex = allPrayers.indexWhere(
          (p) => p.time == currentPrayerTime,
        );
        currentPrayerName = allPrayers[activeListIndex].name;
      }
    }

    if (!isPostAdhan) {
      if (nextPrayer == Prayer.none) {
        // After Isha -> reset day, target tomorrow's Fajr
        final tomorrow = _adhanService.getTomorrowPrayers(
          state.latitude,
          state.longitude,
          state.country,
        );
        timerTarget = tomorrow.fajr;
        activeListIndex = 0;
        currentPrayerName = 'صلاة الفجر';
      } else {
        timerTarget = todayPrayers.timeForPrayer(nextPrayer);
        activeListIndex = allPrayers.indexWhere((p) => p.time == timerTarget);
        currentPrayerName = allPrayers[activeListIndex].name;
      }
    }

    final updatedList = allPrayers.asMap().entries.map((entry) {
      int idx = entry.key;
      PrayerModel p = entry.value;

      bool passed = false;
      bool current = false;

      if (isPostAdhan) {
        passed = idx < activeListIndex;
        current = idx == activeListIndex;
      } else {
        // DAY RESET LOGIC: If we are targeting Fajr (0) but it is currently After Isha,
        // NONE of today's prayers in the UI should be marked as passed.
        if (activeListIndex == 0 && nextPrayer == Prayer.none) {
          passed = false;
          current = idx == 0;
        } else {
          passed = idx < activeListIndex;
          current = idx == activeListIndex;
        }
      }

      return p.copyWith(isPassed: passed, isCurrent: current);
    }).toList();

    emit(
      state.copyWith(
        prayers: updatedList,
        timerTarget: timerTarget,
        isPostAdhan: isPostAdhan,
        currentPrayerIndex: activeListIndex,
        currentPrayerName: currentPrayerName,
      ),
    );
  }

  Future<void> refreshLocation() async {
    await Future.delayed(
      const Duration(milliseconds: 2000),
    ); // Optional: slight delay for UX
    // Simply re-trigger the flow. The Cupertino spinner handles the UI loading state.
    await _initializeLocationFlow();
  }
}
