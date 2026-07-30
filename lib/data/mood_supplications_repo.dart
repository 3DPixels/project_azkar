import 'package:project_azkar/data/dua_model.dart';

import '../utils/enums.dart';

class MoodSupplicationsRepo {
  static final List<DuaModel> _allMoodSupplications = [
    DuaModel(
      dua:
          'لَا إِلَهَ إِلَّا أَنْتَ سُبْحَانَكَ إِنِّي كُنْتُ مِنَ الظَّالِمِينَ',
      benefit: '',
      source: "سورة الأنبياء: ٨٧",
      categories: [.distress, .regret],
    ),
    DuaModel(
      dua:
          'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ، وَالْعَجْزِ وَالْكَسَلِ، وَالْبُخْلِ وَالْجُبْنِ، وَضَلَعِ الدَّيْنِ وَغَلَبَةِ الرِّجَالِ',
      benefit:
          'Abū Saʿīd al-Khudrī (raḍiy Allāhu ʿanhu) narrated that one day, the Messenger of Allah ﷺ entered the masjid. He saw a man from the Anṣār called Abū Umāmah (raḍiy Allāhu ʿanhu). He ﷺ asked, “What is the matter? Why are you sitting in the mosque when it is not the time for prayer?” He replied, “Never-ending worries and debts, O Messenger of Allah.” The Messenger of Allah ﷺ then asked, “Shall I not teach you words by which, when you say them, Allah will remove your worries, and settle your debts?” He replied, “Yes of course, O Messenger of Allah.” He ﷺ said, “Say in the morning and evening [the above].” Abū Umāmah (raḍiy Allāhu ʿanhu) said, “Then I did that, and Allah removed my worries and settled my debts.” (Abū Dāwūd 1555)',
      source: "ابو داوود",
      categories: [.distress, .sadness],
    ),
    DuaModel(
      dua: 'رَبِّ إِنِّيْ لِمَآ أَنْزَلْتَ إِلَيَّ مِنْ خَيْرٍ فَقِيْرٌ',
      benefit: '',
      source: 'سورة القصص: ٢٤',
      categories: [.distress, .sadness],
    ),
    DuaModel(
      dua:
          'رَبِّ أَعُوْذُ بِكَ مِنْ هَمَزَاتِ الشَّيَاطِيْنِ ، وَأَعُوذُ بِكَ رَبِّ أَنْ يَّحْضُرُوْنِ',
      benefit: '',
      source: "سورة المؤمنون: ٩٧-٩٨",
      categories: [.sadness],
    ),
    DuaModel(
      dua:
          'اَللّٰهُمَّ إِنِّيْ أَعُوْذُ بِكَ مِنْ ضِيْقِ الدُّنْيَا وَضِيْقِ يَوْمِ الْقِيَامَةِ',
      benefit:
          'Sharīq al-Hawzānī (raḥimahullāh) narrates that I entered upon Aisha (raḍiy Allāhu ‘anhā) and I asked her: “With which supplication did the Messenger of Allah ﷺ begin his Salāh when he woke up at night?” She replied: “You have asked me regarding something which no one has asked me before.” When he woke up at night, he uttered: Allāhu Akbar (Allah is the Greatest) ten times, and uttered Alḥamdullillāh (All praise be to Allah) ten times, and said Subḥāna-llāhi wa bi ḥamdih. (Allah is free from imperfection, and all praise is due to Him.) ten times, and said: Subḥānal Malik al-Quddūs (How perfect is the Sovereign, the Most Holy) ten times, and asked Allah’s forgiveness ten times, and said: “There is no god but Allah” ten times, and then said: [the above] ten times. He then began the Salāh. (Abū Dāwūd 5085)',
      source: "ابو داوود",
      categories: [.sadness],
    ),
    DuaModel(
      dua: "حَسْبُنَا اللَّهُ وَنِعْمَ الْوَكِيلَُ",
      benefit: '',
      source: "سورة آل عمران: ١٧٣",
      categories: [.distress, .injustice],
    ),
    DuaModel(
      dua:
          'اللَّهُمَّ إِنِّي عَبْدُكَ، ابْنُ عَبْدِكَ،ابْنُ أَمَتِكَ، نَاصِيَتِي بِيَدِكَ،مَاضٍ فِيَّ حُكْمُكَ اللَّهُمَّ إِنِّي عَبْدُكَ، ابْنُ عَبْدِكَ،ابْنُ أَمَتِكَ، نَاصِيَتِي بِيَدِكَ،مَاضٍ فِيَّ حُكْمُكَ',
      benefit: '',
      source: "حصن المسلم",
      categories: [DuaCategories.sadness],
    ),
    DuaModel(
      dua:
          'رَبَّنَا ظَلَمْنَا أَنفُسَنَا وَإِن لَّمْ تَغْفِرْ لَنَا وَتَرْحَمْنَا لَنَكُونَنَّ مِنَ الْخَاسِرِينَ',
      benefit: '',
      source: "حصن المسلم",
      categories: [DuaCategories.regret],
    ),
    DuaModel(
      dua: 'رَبِّ إِنِّيْ ظَلَمْتُ نَفْسِيْ فَاغْفِرْ لِيْ',
      benefit: '',
      source: 'سورة القصص: ١٦',
      categories: [DuaCategories.regret],
    ),
    DuaModel(
      dua:
          'رَبَّنَا ظَلَمْنَآ أَنْفُسَنَا وَإِنْ لَّمْ تَغْفِرْ لَنَا وَتَرْحَمْنَا لَنَكُوْنَنَّ مِنَ الْخٰسِرِيْنَ',
      benefit: '',
      source: "سورة الأعراف: ٢٣",
      categories: [DuaCategories.regret],
    ),
    DuaModel(
      dua:
          'أَنْتَ وَلِيُّنَا فَاغْفِرْ لَنَا وَارْحَمْنَا ۖ وَأَنْتَ خَيْرُ الْغَافِرِيْنَ',
      benefit: '',
      source: "سورة الأعراف: ١٥٥",
      categories: [DuaCategories.regret],
    ),
    DuaModel(
      dua:
          'اَللّٰهُمَّ اغْفِرْ لِيْ خَطِيْئَتِيْ وَجَهْلِيْ وَإِسْرَافِيْ فِيْ أَمْرِيْ ، وَمَا أَنْتَ أَعْلَمُ بِهِ مِنِّيْ ، اَللّٰهُمَّ اغْفِرْ لِيْ جِدِّيْ وَهَزْلِيْ وَخَطَئِيْ وَعَمْدِيْ وَكُلُّ ذٰلِكَ عِنْدِيْ ، اَللّٰهُمَّ اغْفِرْ لِيْ مَا قَدَّمْتُ وَمَا أَخَّرْتُ ، وَمَا أَسْرَرْتُ وَمَا أَعْلَنْتُ ، وَمَا أَنْتَ أَعْلَمُ بِهِ مِنِّـيْ ، أَنْتَ الْمُقَدِّمُ وَأَنْتَ الْمُؤَخِّرُ ، وَأَنْتَ عَلَىٰ كُلِّ شَيْءٍ قَدِيْرٌ',
      benefit:
          'Abū Mūsā al-‘Ashʿarī (raḍiy Allāhu ‘anhu) reported from his father that the Messenger of Allah ﷺ would supplicate with [the above]. (Muslim 2719)',
      source: "رواه مسلم",
      categories: [DuaCategories.regret],
    ),
  ];

  static List<DuaModel> get allSupplications => _allMoodSupplications;

  static List<DuaModel> getSupplicationByCategory(DuaCategories category) {
    return _allMoodSupplications.where((item) {
      // Check if categories is not null, then check if it contains the specific category
      return item.categories != null && item.categories!.contains(category);
    }).toList();
  }
}
