import 'package:adhan/adhan.dart';
import 'package:hijri/hijri_calendar.dart';

class PrayerService {
  String getFormattedHijriDate() {
    HijriCalendar.setLocal('ar');
    final today = HijriCalendar.now();
    return '${today.longMonthName}، ${today.hYear}';
  }

  Map<String, dynamic> getTodayPrayerData(double lat, double lng) {
    final coordinates = Coordinates(lat, lng);
    final params = CalculationMethod.egyptian.getParameters();
    final prayerTimes = PrayerTimes.today(coordinates, params);

    final nextPrayer = prayerTimes.nextPrayer();
    final nextPrayerDateTime = prayerTimes.timeForPrayer(nextPrayer)?.toLocal();

    final List<Map<String, dynamic>> list = [
      {'title': 'صلاة الفجر', 'time': prayerTimes.fajr, 'enum': Prayer.fajr},
      {
        'title': 'صلاة الشروق',
        'time': prayerTimes.sunrise,
        'enum': Prayer.sunrise,
      },
      {'title': 'صلاة الظهر', 'time': prayerTimes.dhuhr, 'enum': Prayer.dhuhr},
      {'title': 'صلاة العصر', 'time': prayerTimes.asr, 'enum': Prayer.asr},
      {
        'title': 'صلاة المغرب',
        'time': prayerTimes.maghrib,
        'enum': Prayer.maghrib,
      },
      {'title': 'صلاة العشاء', 'time': prayerTimes.isha, 'enum': Prayer.isha},
    ];

    return {
      'prayers': list,
      'nextPrayer': nextPrayer,
      'nextPrayerDateTime': nextPrayerDateTime,
    };
  }
}
