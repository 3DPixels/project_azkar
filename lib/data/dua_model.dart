import '../utils/enums.dart';

class DuaModel {
  final int count;
  final String dua;
  final String source; // source of ayah/dua
  final String benefit; // the benefit of dua
  final String? benefitSource; // the benefit of dua
  final String? audioPath;
  final String? description;
  final List<DuaTime>? time; // time of dua
  final List<MoodCategories>? categories;

  DuaModel({
    this.count = 1,
    required this.dua,
    required this.source,
    required this.benefit,
    this.benefitSource,
    this.audioPath,
    this.description,
    this.time,
    this.categories,
  });
}
