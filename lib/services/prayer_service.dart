import 'package:adhan/adhan.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

class PrayerService {
  String getFormattedHijriDate([DateTime? date]) {
    HijriCalendar.setLocal('ar');
    final hijri = HijriCalendar.fromDate(date ?? DateTime.now());
    return '${hijri.hDay} ${hijri.longMonthName} ${hijri.hYear} هـ';
  }

  Map<String, dynamic> getTodayPrayerData(
    double lat,
    double lng, {
    DateTime? targetDate,
  }) {
    final now = targetDate ?? DateTime.now();
    final coordinates = Coordinates(lat, lng);
    final params = CalculationMethod.egyptian.getParameters();

    final prayerTimes = PrayerTimes(
      coordinates,
      DateComponents.from(now),
      params,
    );

    Prayer current = prayerTimes.currentPrayer();
    Prayer next = prayerTimes.nextPrayer();
    DateTime? nextPrayerDateTime = prayerTimes.timeForPrayer(next)?.toLocal();

    // Edge case: After Isha, the next prayer is tomorrow's Fajr
    if (next == Prayer.none || current == Prayer.isha) {
      final tomorrow = now.add(const Duration(days: 1));
      final tomorrowPrayerTimes = PrayerTimes(
        coordinates,
        DateComponents.from(tomorrow),
        params,
      );
      next = Prayer.fajr;
      nextPrayerDateTime = tomorrowPrayerTimes.fajr.toLocal();
    }

    final timeFormatter = DateFormat('hh:mm a', 'ar_EG');

    final List<Map<String, dynamic>> prayersList = [
      {
        'title': 'صلاة الفجر',
        'timeStr': timeFormatter.format(prayerTimes.fajr.toLocal()),
        'time': prayerTimes.fajr.toLocal(),
        'enum': Prayer.fajr,
        'isPassed': now.isAfter(prayerTimes.fajr),
        'isCurrent': current == Prayer.fajr,
        'isNext': next == Prayer.fajr,
      },
      {
        'title': 'الشروق',
        'timeStr': timeFormatter.format(prayerTimes.sunrise.toLocal()),
        'time': prayerTimes.sunrise.toLocal(),
        'enum': Prayer.sunrise,
        'isPassed': now.isAfter(prayerTimes.sunrise),
        'isCurrent': current == Prayer.sunrise,
        'isNext': next == Prayer.sunrise,
      },
      {
        'title': 'صلاة الظهر',
        'timeStr': timeFormatter.format(prayerTimes.dhuhr.toLocal()),
        'time': prayerTimes.dhuhr.toLocal(),
        'enum': Prayer.dhuhr,
        'isPassed': now.isAfter(prayerTimes.dhuhr),
        'isCurrent': current == Prayer.dhuhr,
        'isNext': next == Prayer.dhuhr,
      },
      {
        'title': 'صلاة العصر',
        'timeStr': timeFormatter.format(prayerTimes.asr.toLocal()),
        'time': prayerTimes.asr.toLocal(),
        'enum': Prayer.asr,
        'isPassed': now.isAfter(prayerTimes.asr),
        'isCurrent': current == Prayer.asr,
        'isNext': next == Prayer.asr,
      },
      {
        'title': 'صلاة المغرب',
        'timeStr': timeFormatter.format(prayerTimes.maghrib.toLocal()),
        'time': prayerTimes.maghrib.toLocal(),
        'enum': Prayer.maghrib,
        'isPassed': now.isAfter(prayerTimes.maghrib),
        'isCurrent': current == Prayer.maghrib,
        'isNext': next == Prayer.maghrib,
      },
      {
        'title': 'صلاة العشاء',
        'timeStr': timeFormatter.format(prayerTimes.isha.toLocal()),
        'time': prayerTimes.isha.toLocal(),
        'enum': Prayer.isha,
        'isPassed': now.isAfter(prayerTimes.isha),
        'isCurrent': current == Prayer.isha,
        'isNext': next == Prayer.isha,
      },
    ];

    String currentOrNextTitle = 'صلاة الفجر';
    for (var p in prayersList) {
      if (p['enum'] == (current != Prayer.none ? current : next)) {
        currentOrNextTitle = p['title'];
        break;
      }
    }

    return {
      'prayers': prayersList,
      'currentOrNextPrayerTitle': currentOrNextTitle,
      'nextPrayerDateTime': nextPrayerDateTime,
    };
  }
}
