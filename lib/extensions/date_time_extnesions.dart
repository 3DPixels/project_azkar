import 'package:hijri/hijri_calendar.dart';

extension HijriDateExtension on DateTime {
  String toHijriString() {
    HijriCalendar.setLocal('ar');
    return HijriCalendar.fromDate(this).toFormat("dd MMMM yyyy هـ");
  }
}
