class ZekrModel {
  String? title;
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
    this.title,
  });
}

enum ZekrTime { day, night, afterSalah }

enum ZekrType { ayah, dua }

enum Categories {
  happy,
  grateful,
  sad,
  angry,
  depressed,
  anxious,
  bored,
  confused,
  lonely,
  suicidal,
  greedy,
  aroused,
  guilty,
  hurt,
  hypocritical,
  indecisive,
  jealous,
  lazy,
  nervous,
  tired,
  scared,
  unloved,
  weak,
  hatred,
  humiliated,
  impatient,
  insecure,
  inDebt, // When the user is in debt
  seekingGuidance, // For making a decision (Istikhara)
  inNeed, // When the user wants or needs something
  facingDifficulty, // For general hardship
  seekingForgiveness,
  expressingGratitude,
}
