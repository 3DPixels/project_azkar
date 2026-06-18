import 'package:flutter/material.dart';
import 'package:project_azkar/data/mood_supplications_repo.dart';
import 'package:project_azkar/pages/supplications/widgets/dua_card.dart';
import 'package:project_azkar/utils/app_colors.dart';

class AzkarList extends StatelessWidget {
  const AzkarList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [Text('التقدم اليومي'), Text('5/24')],
        ),
        LinearProgressIndicator(value: .3),
        DuaCard(
          supplication: MoodSupplicationsRepo.allSupplications.first,
          buttonsColor: AppColors.dsPrimary,
          borderColor: AppColors.dsNeutral,
          bottomColor: AppColors.darkNavBarBackground,
          containerBackgroundColor: AppColors.darkSurface,
        ),
      ],
    );
  }
}
