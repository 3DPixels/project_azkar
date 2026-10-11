import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_azkar/widgets/calculation_method_dialog.dart';

import '../../cubits/prayer_times_cubit.dart';
import '../../cubits/settings_cubit.dart';
import '../../services/adhan_service.dart';
import '../../services/notification_service.dart';

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

        return Column(
          children: [
            SwitchListTile(
              activeThumbColor: Colors.green,
              title: const Text('تفعيل إشعارات الصلاة'),
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
            const Divider(color: Colors.white12, height: 1),
            SwitchListTile(
              activeThumbColor: Colors.green,
              title: const Text('أذكار الصباح والمساء'),
              subtitle: const Text(
                'بعد الفجر والعصر بـ ١٠ دقائق',
                style: TextStyle(fontSize: 12, color: Colors.white54),
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
            const Divider(color: Colors.white12, height: 1),
            ListTile(
              title: const Text('طريقة الحساب'),
              subtitle: Text(
                subtitleText,
                style: const TextStyle(fontSize: 12, color: Colors.white54),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.white54,
              ),
              onTap: () {
                CalculationMethodDialog.show(context);
              },
            ),
            const Divider(color: Colors.white12, height: 1),
            FilledButton(
              onPressed: () {
                NotificationService().showNotification();
              },
              child: const Text('Test Notification'),
            ),
          ],
        );
      },
    );
  }
}
