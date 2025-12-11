import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_azkar/providers/settings_cubit/settings_cubit.dart';

import '../data/zekr_model.dart';
import 'azkar_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الرئيسية'),
        actions: [
          IconButton.filled(
            onPressed: () => context.read<SettingsCubit>().changeTheme(),
            icon: Icon(Icons.dark_mode),
          ),
        ],
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AzkarPage(
                    time: ZekrTime.day,
                    categories: Categories.happy,
                  ),
                ),
              );
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('أذكار الصباح'),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AzkarPage(
                    time: ZekrTime.night,
                    categories: Categories.happy,
                  ),
                ),
              );
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('أذكار المساء'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
