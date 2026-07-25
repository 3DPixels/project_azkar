import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_azkar/widgets/dua_card.dart';
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

        return CustomScrollView(
          key: const PageStorageKey<String>('azkar_list_tab'),
          slivers: [
            // Choice Chips
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 20),
              sliver: SliverToBoxAdapter(
                child: Row(
                  spacing: 12,
                  children: [
                    ChoiceChip(
                      label: const Text('أذكار باقية'),
                      selected: !state.showReadList,
                      onSelected: (val) =>
                          context.read<AzkarCubit>().toggleList(false),
                      selectedColor: AppColors.primary.withValues(alpha: 0.2),
                      checkmarkColor: AppColors.primary,
                      backgroundColor: AppColors.darkSurface,
                    ),
                    ChoiceChip(
                      label: const Text('تمت قراءتها'),
                      selected: state.showReadList,
                      onSelected: (val) =>
                          context.read<AzkarCubit>().toggleList(true),
                      selectedColor: AppColors.primary.withValues(alpha: 0.2),
                      checkmarkColor: AppColors.primary,
                      backgroundColor: AppColors.darkSurface,
                    ),
                  ],
                ),
              ),
            ),

            // The List
            displayItems.isEmpty
                ? SliverFillRemaining(
                    child: Center(
                      child: Text(
                        state.showReadList
                            ? 'لا توجد أذكار مقروءة'
                            : 'تم الانتهاء من الأذكار!',
                      ),
                    ),
                  )
                : SliverList.builder(
                    itemCount: displayItems.length,
                    itemBuilder: (context, index) {
                      final item = displayItems[index];
                      return DuaCard(
                        key: ValueKey(item.supplication.dua),
                        supplication: item.supplication,
                        buttonsColor: AppColors.primary,
                        borderColor: AppColors.primary.withValues(alpha: 0.15),
                        bottomColor: AppColors.darkNavBarBackground,
                        containerBackgroundColor: AppColors.darkSurface,
                        enableCounter: true,
                        currentCount: item.currentCount,
                        targetCount: item.targetCount,
                        onTap: () => context.read<AzkarCubit>().decrementCount(
                          item.supplication,
                        ),
                        onUndo: () => context.read<AzkarCubit>().undoCount(
                          item.supplication,
                        ),
                        onSkip: () => context.read<AzkarCubit>().skipZekr(
                          item.supplication,
                        ),
                      );
                    },
                  ),
          ],
        );
      },
    );
  }
}
