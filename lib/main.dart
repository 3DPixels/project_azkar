import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_azkar/pages/main_page.dart';
import 'package:project_azkar/providers/settings_cubit/settings_cubit.dart';
import 'package:project_azkar/services/cache_helper.dart';
import 'package:project_azkar/utils/dark_theme.dart';
import 'package:project_azkar/utils/light_theme.dart';

import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await NotificationService().initialize();
  await CacheHelper.init(); //cache services
  //To prevent app from landscape orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Azkar App',
            locale: Locale('ar'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: [Locale('ar')],
            theme: lightTheme(),
            darkTheme: darkTheme(),
            themeMode: state.themeMode,
            home: const MainPage(),
          );
        },
      ),
    );
  }
}
