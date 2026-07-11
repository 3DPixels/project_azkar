import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_azkar/data/zekr_repo.dart';
import 'package:project_azkar/pages/supplications/widgets/dua_card.dart';
import 'package:project_azkar/utils/app_colors.dart';

import '../../../cubits/azkar/azkar_cubit.dart';

class AzkarList extends StatelessWidget {
  const AzkarList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AzkarCubit, AzkarState>(
      builder: (context, state) {
        // Decide which list to show based on the ChoiceChip
        final displayItems = state.showReadList
            ? state.readItems
            : state.unreadItems;

        return Column(
          spacing: 20,
          children: [
            // Progress Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('التقدم اليومي'),
                Text('${state.completedZekr}/${state.totalZekr}'),
              ],
            ),
            LinearProgressIndicator(
              value: state.progress,
              backgroundColor: AppColors.darkSurface,
              color: AppColors.dsPrimary,
            ),

            // Choice Chips
            Row(
              spacing: 12,
              children: [
                ChoiceChip(
                  label: Text('أذكار باقية'),
                  selected: !state.showReadList,
                  onSelected: (val) =>
                      context.read<AzkarCubit>().toggleList(false),
                  selectedColor: AppColors.dsPrimary.withValues(alpha: 0.2),
                  checkmarkColor: AppColors.dsPrimary,
                  backgroundColor: AppColors.darkSurface,
                ),
                ChoiceChip(
                  label: Text('تمت قراءتها'),
                  selected: state.showReadList,
                  onSelected: (val) =>
                      context.read<AzkarCubit>().toggleList(true),
                  selectedColor: AppColors.dsPrimary.withValues(alpha: 0.2),
                  checkmarkColor: AppColors.dsPrimary,
                  backgroundColor: AppColors.darkSurface,
                ),
              ],
            ),

            // The List
            Expanded(
              child: displayItems.isEmpty
                  ? Center(
                      child: Text(
                        state.showReadList
                            ? 'لا توجد أذكار مقروءة'
                            : 'تم الانتهاء من الأذكار!',
                      ),
                    )
                  : ListView.separated(
                      itemCount: displayItems.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final item = displayItems[index];
                        return DuaCard(
                          supplication: item.supplication,
                          buttonsColor: AppColors.dsPrimary,
                          borderColor: AppColors.dsPrimary.withValues(
                            alpha: 0.15,
                          ),
                          bottomColor: AppColors.darkNavBarBackground,
                          containerBackgroundColor: AppColors.darkSurface,
                          // Enable the counter and pass the state variables
                          enableCounter: true,
                          currentCount: item.currentCount,
                          targetCount: item.targetCount,
                          onTap: () => context
                              .read<AzkarCubit>()
                              .decrementCount(item.supplication),
                          onUndo: () => context.read<AzkarCubit>().undoCount(
                            item.supplication,
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
