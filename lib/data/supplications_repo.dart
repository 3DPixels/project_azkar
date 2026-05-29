import 'package:project_azkar/data/dua_model.dart';

import '../utils/enums.dart';

class SupplicationsRepo {
  static final List<DuaModel> _allSupplications = [
    DuaModel(
      dua:
          'لَا إِلَهَ إِلَّا أَنْتَ سُبْحَانَكَ إِنِّي كُنْتُ مِنَ الظَّالِمِينَ',
      benefit:
          '"There is no deity except You; exalted are You. Indeed, I have been of the wrongdoers."',
      source: "سورة الأنبياء: ٨٧",
      categories: [Categories.helpless],
    ),
    DuaModel(
      dua:
          'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ، وَالْعَجْزِ وَالْكَسَلِ، وَالْبُخْلِ وَالْجُبْنِ، وَضَلَعِ الدَّيْنِ وَغَلَبَةِ الرِّجَالِ',
      benefit:
          '"O Allah, I seek refuge in You from  anxiety and sorrow, weakness and laziness, miserliness and cowardice, the burden of debts and from being overpowered by men."',
      source: "صحيح البخاري",
      categories: [Categories.helpless],
    ),
    DuaModel(
      dua: "حَسْبُنَا اللَّهُ وَنِعْمَ الْوَكِيلَُ",
      benefit:
          '"Sufficient for us is Allah, and [He is] the best Disposer of affairs."',
      source: "سورة آل عمران: ١٧٣",
      categories: [Categories.helpless, .oppressed],
    ),
    DuaModel(
      dua:
          'اللَّهُمَّ إِنِّي عَبْدُكَ، ابْنُ عَبْدِكَ،ابْنُ أَمَتِكَ، نَاصِيَتِي بِيَدِكَ،مَاضٍ فِيَّ حُكْمُكَ اللَّهُمَّ إِنِّي عَبْدُكَ، ابْنُ عَبْدِكَ،ابْنُ أَمَتِكَ، نَاصِيَتِي بِيَدِكَ،مَاضٍ فِيَّ حُكْمُكَ',
      benefit:
          '"O Allah, I am Your slave, son of Your slave, son of Your female slave, my forelock is in Your hand..."',
      source: "حصن المسلم",
      categories: [Categories.sad],
    ),
    DuaModel(
      dua:
          'رَبَّنَا ظَلَمْنَا أَنفُسَنَا وَإِن لَّمْ تَغْفِرْ لَنَا وَتَرْحَمْنَا لَنَكُونَنَّ مِنَ الْخَاسِرِينَ',
      benefit:
          '"Our Lord, we have wronged ourselves, and if You do not forgive us and have mercy upon us, we will surely be among the losers."',
      source: "حصن المسلم",
      categories: [Categories.negligent],
    ),
  ];

  static List<DuaModel> get allSupplications => _allSupplications;

  static List<DuaModel> getSupplicationByCategory(Categories category) {
    return _allSupplications.where((item) {
      // Check if categories is not null, then check if it contains the specific category
      return item.categories != null && item.categories!.contains(category);
    }).toList();
  }
}
