import 'package:flutter/material.dart';
import 'package:project_azkar/utils/app_colors.dart';

class ZekrCard extends StatefulWidget {
  const ZekrCard({super.key});

  @override
  State<ZekrCard> createState() => _ZekrCardState();
}

class _ZekrCardState extends State<ZekrCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: BoxBorder.all(color: AppColors.dsNeutral),
        color: AppColors.darkSurface,
      ),
      // padding: EdgeInsets.only(left: 20, top: 20, right: 20),
      child: Column(
        spacing: 10,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.dsPrimary,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                child: Text(
                  'آية الكرسي',
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(color: Colors.white),
                ),
              ),
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.share)),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.play_circle_outline),
              ),
            ],
          ),
          Text(
            'اللّهُ لاَ إِلَـهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاء وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ.',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontFamily: 'NotoSansArabicVar'),
          ),
          Text('سورة البقرة - الآية 255'),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
              border: BorderDirectional(
                top: BorderSide(color: AppColors.dsNeutral),
              ),
              color: AppColors.darkNavBarBackground,
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text('يقرأ مرة واحدة'),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: BoxBorder.all(color: AppColors.dsNeutral),
                    color: AppColors.darkSurface,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Row(
                    spacing: 6,
                    children: [Icon(Icons.check), Text('1x')],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
