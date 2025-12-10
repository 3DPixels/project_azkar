import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_azkar/pages/settings.dart';
import 'package:project_azkar/providers/settings_cubit/settings_cubit.dart';

import 'about_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('الرئيسية')),
      body: Center(
        child: FilledButton(
          onPressed: () async {
            context.read<SettingsCubit>().changeTheme();
          },
          child: Text('Send Notification'),
        ),
      ),
    );
  }
}
