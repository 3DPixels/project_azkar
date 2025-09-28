import '../utils/constants.dart';

class ZekrModel {
  int count; // repeat times
  String zekr;
  ZekrType type; // ayah or dua
  List<String>
  benefit; // the benefit of zekr (could be multiple depending on the occasion)
  List<ZekrTime> time; // category of zekr
  String? ayahSource; // source of ayah in quran
  List<Categories>? categories;

  ZekrModel({
    required this.count,
    required this.zekr,
    required this.type,
    required this.benefit,
    required this.time,
    this.ayahSource,
    this.categories,
  });
}
