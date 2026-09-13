import '../../utils/enums.dart';

class PrayerModel {
  final PrayerCategories prayerType;
  final String title;
  final String subtitle;
  final String imagePath;
  final String iconPath;
  final String? info;
  final String? chipText;
  final String? hintText;
  final PrayerDetailsModel? importantStep;
  final List<PrayerDetailsModel> prayerSteps;

  const PrayerModel({
    required this.prayerType,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.iconPath,
    this.info,
    this.chipText,
    this.hintText,
    this.importantStep,
    required this.prayerSteps,
  });
}

class PrayerDetailsModel {
  final String title;
  final String subtitle;
  final String? desc;

  const PrayerDetailsModel(this.title, this.subtitle, {this.desc});
}
