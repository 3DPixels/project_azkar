import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_azkar/utils/app_colors.dart';
import 'package:reel_text/reel_text.dart';
import '../../../cubits/azkar/azkar_cubit.dart';
import '../../../utils/app_fonts.dart';

class AzkarSingle extends StatelessWidget {
  const AzkarSingle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AzkarCubit, AzkarState>(
      builder: (context, state) {
        // Get the first unread item
        final currentItem = state.unreadItems.isNotEmpty
            ? state.unreadItems.first
            : null;

        if (currentItem == null) {
          return const Center(child: Text('تم الانتهاء من جميع الأذكار!'));
        }

        return Column(
          children: [
            // Progress Bar at the top of the card view
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('التقدم'),
                Text('${state.completedZekr} / ${state.totalZekr}'),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: state.progress,
              backgroundColor: AppColors.darkSurface,
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 24),

            // The Main Focus Card
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.darkSurface,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.1),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Count Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        '${currentItem.targetCount} مرة واحدة', // Or adjust based on count logic
                        style: const TextStyle(color: AppColors.primary),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Dua Text
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          currentItem.supplication.dua,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontFamily: AppFonts.notoSans,
                                height: 1.8,
                              ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    // Source
                    Text(
                      currentItem.supplication.source,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Big Circular Tap Button
            GestureDetector(
              onTap: () => context.read<AzkarCubit>().decrementCount(
                currentItem.supplication,
              ),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: ReelText(
                  '${currentItem.currentCount}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('اضغط للعد', style: TextStyle(color: Colors.white54)),
            const SizedBox(height: 40),
          ],
        );
      },
    );
  }
}
