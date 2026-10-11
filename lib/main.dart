import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_azkar/pages/main_page.dart';
import 'package:project_azkar/services/cache_service.dart';
import 'package:project_azkar/utils/dark_theme.dart';

import 'cubits/prayer_times_cubit.dart';
import 'cubits/settings_cubit.dart';
import 'l10n/app_localizations.dart';
import 'services/adhan_service.dart';
import 'services/location_service.dart';
import 'services/notification_scheduler.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheService.init();
  final notificationService = NotificationService();
  await notificationService.init();

  final adhanService = AdhanService();
  final locationService = LocationService();
  final scheduler = NotificationScheduler(adhanService, notificationService);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(
      MyApp(
        adhanService: adhanService,
        locationService: locationService,
        notifiService: notificationService,
        scheduler: scheduler,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AdhanService adhanService;
  final LocationService locationService;
  final NotificationService notifiService;
  final NotificationScheduler scheduler;

  const MyApp({
    super.key,
    required this.adhanService,
    required this.locationService,
    required this.notifiService,
    required this.scheduler,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PrayerTimesCubit(locationService, adhanService),
        ),
        BlocProvider(create: (_) => SettingsCubit(scheduler, notifiService)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Azkar App',
        locale: Locale('ar', 'SA'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: [Locale('ar')],
        theme: darkTheme(),
        home: const MainPage(),
      ),
    );
  }
}
