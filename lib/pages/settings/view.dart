import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_azkar/pages/about_page.dart';
import 'package:project_azkar/widgets/calculation_method_dialog.dart';
import 'package:project_azkar/utils/app_colors.dart';

import '../../cubits/prayer_times_cubit.dart';
import '../../cubits/settings_cubit.dart';
import '../../services/adhan_service.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, settingsState) {
        final pState = context.watch<PrayerTimesCubit>().state;
        final autoMethod = AdhanService.getAutoMethodForCountry(pState.country);
        final isAuto = settingsState.selectedCalculationMethod == null;

        final subtitleText = isAuto
            ? 'تلقائي (${AdhanService.getMethodName(autoMethod)})'
            : AdhanService.getMethodName(
                settingsState.selectedCalculationMethod!,
              );

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Material(
              color: AppColors.darkSurface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: AppColors.darkBorder),
              ),
              clipBehavior: Clip
                  .antiAlias, // Ensures the splash doesn't bleed outside the rounded corners
              child: Column(
                children: [
                  SwitchListTile.adaptive(
                    activeThumbColor: Colors.white,
                    activeTrackColor: AppColors.secondary,
                    inactiveTrackColor: AppColors.darkPageBG,
                    title: const Text(
                      'تفعيل إشعارات الصلاة',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    value: settingsState.prayerNotifications,
                    onChanged: (val) {
                      context.read<SettingsCubit>().togglePrayerNotifications(
                        val,
                        lat: pState.latitude,
                        lng: pState.longitude,
                        country: pState.country,
                      );
                    },
                  ),
                  const Divider(color: AppColors.darkBorder, height: 1),
                  SwitchListTile(
                    activeThumbColor: Colors.white,
                    activeTrackColor: AppColors.secondary,
                    inactiveTrackColor: AppColors.darkPageBG,
                    title: const Text(
                      'أذكار الصباح والمساء',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: const Text(
                      'بعد الفجر والعصر بـ ١٠ دقائق',
                      style: TextStyle(fontSize: 12, color: AppColors.hint),
                    ),
                    value: settingsState.morningNightAzkarNotifications,
                    onChanged: (val) {
                      context.read<SettingsCubit>().toggleMorningNightAzkar(
                        val,
                        lat: pState.latitude,
                        lng: pState.longitude,
                        country: pState.country,
                      );
                    },
                  ),
                  const Divider(color: AppColors.darkBorder, height: 1),
                  ListTile(
                    title: const Text(
                      'طريقة الحساب',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      subtitleText,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.hint,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.hint,
                      size: 16,
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const CalculationMethodDialog(),
                      );
                    },
                  ),
                  const Divider(color: AppColors.darkBorder, height: 1),
                  ListTile(
                    title: const Text(
                      'حول المطور',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: const Icon(
                      Icons.badge_outlined,
                      color: AppColors.hint,
                      size: 20,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
