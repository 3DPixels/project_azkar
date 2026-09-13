import 'package:project_azkar/data/models/prayer_model.dart';
import 'package:project_azkar/utils/app_icons.dart';
import 'package:project_azkar/utils/app_images.dart';
import 'package:project_azkar/utils/enums.dart';

abstract class PrayersRepo {
  static final List<PrayerModel> _allPrayers = [
    PrayerModel(
      prayerType: PrayerCategories.wetr,
      title: 'صلاة الوتر',
      subtitle: 'قيام الليل',
      imagePath: AppImages.prayerWetr,
      iconPath: AppIcons.hilalCloudy,
      prayerSteps: [PrayerDetailsModel('', '')],
    ),
    PrayerModel(
      prayerType: PrayerCategories.estkhara,
      title: 'صلاة الاستخارة',
      subtitle:
          'الاستخارة هي طلب الخيرة من الله تعالى في أمر مباح، وهي سنة مؤكدة لمن أراد أن يقدم على أمر واحتار فيه.',
      imagePath: AppImages.prayerEstkhara,
      iconPath: AppIcons.compass,
      chipText: 'دليل شامل',
      info: 'تجنب الصلاة عند شروق وغروب الشمس',
      importantStep: PrayerDetailsModel(
        'دعاء الاستخارة',
        'اللَّهُمَّ إنِّي أَسْتَخِيرُكَ بِعِلْمِكَ، وَأَسْتَقْدِرُكَ بِقُدْرَتِكَ، وَأَسْأَلُكَ مِنْ فَضْلِكَ الْعَظِيمِ فَإِنَّكَ تَقْدِرُ وَلاَ أَقْدِرُ، وَتَعْلَمُ وَلاَ أَعْلَمُ، وَأَنْتَ عَلاَّمُ الْغُيُوبِ',
      ),
      prayerSteps: [
        PrayerDetailsModel(
          'الوضوء والنية',
          'توضأ وضوءك للصلاة، وانوِ صلاة الاستخارة قبل تكبيرة الإحرام.',
        ),
        PrayerDetailsModel(
          'صلاة ركعتين',
          'صلِّ ركعتين من غير الفريضة، يُستحب قراءة سورة الكافرون في الركعة الأولى والإخلاص في الثانية.',
        ),
        PrayerDetailsModel(
          'الدعاء',
          'بعد التسليم، ارفع يديك مستقبلاً القبلة، وابدأ بحمد الله والصلاة على النبي ﷺ، ثم اقرأ دعاء الاستخارة.',
        ),
      ],
    ),
    PrayerModel(
      prayerType: PrayerCategories.janazah,
      title: 'صلاة الجنازة',
      subtitle:
          'صلاة الجنازة فرض كفاية، ولها أجر عظيم، وهي دعاء للميت بالرحمة والمغفرة، وتذكير للحي بالمصير المحتوم.',
      imagePath: AppImages.prayerJanazah,
      iconPath: AppIcons.grass,
      chipText: 'فضلها',
      hintText: '٢ دقيقة',
      info:
          'السنة الإسرار في القراءة والدعاء، ورفع اليدين في التكبيرة الأولى، ويستحب في جميع التكبيرات.',
      prayerSteps: [
        PrayerDetailsModel(
          'التكبيرة الأولى',
          'يقرأ بعد التكبيرة الأولى سورة الفاتحة سراً.',
          desc:
              'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ ۝ ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَٰلَمِينَ ۝ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ ۝ مَٰلِكِ يَوْمِ ٱلدِّينِ',
        ),
        PrayerDetailsModel(
          'التكبيرة الثانية',
          'يصلى على النبي ﷺ الصلاة الإبراهيمية.',
          desc:
              'اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ، كَمَا صَلَّيْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ، إِنَّكَ حَمِيدٌ مَجِيدٌ',
        ),
        PrayerDetailsModel(
          'التكبيرة الثالثة',
          'يدعو للميت بالرحمة والمغفرة بإخلاص.',
          desc:
              'اللَّهُمَّ اغْفِرْ لَهُ وَارْحَمْهُ، وَعَافِهِ وَاعْفُ عَنْهُ، وَأَكْرِمْ نُزُلَهُ، وَوَسِّعْ مُدْخَلَهُ',
        ),
        PrayerDetailsModel(
          'التكبيرة الرابعة',
          'يدعو للمسلمين ثم يسلم تسليمة واحدة عن يمينه.',
          desc:
              'اللَّهُمَّ لَا تَحْرِمْنَا أَجْرَهُ، وَلَا تَفْتِنَّا بَعْدَهُ، وَاغْفِرْ لَنَا وَلَهُ',
        ),
      ],
    ),
  ];

  static List<PrayerModel> get allPrayers => _allPrayers;

  static PrayerModel getPrayerByType(PrayerCategories type) {
    return _allPrayers.firstWhere((item) {
      return item.prayerType == type;
    });
  }
}
