import 'package:flutter/material.dart';
import 'package:project_azkar/utils/app_colors.dart';

import 'azkar_list.dart';
import 'azkar_single.dart';

class AzkarPage extends StatelessWidget {
  const AzkarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Zekr')),
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            spacing: 32,
            children: [
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.darkSurface,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(4.0), // Padding around the pill
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent, // Removes the bottom line
                  splashBorderRadius: BorderRadius.circular(8),
                  // The sliding pill
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.dsSecondary,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: AppColors.dsNeutral,
                  tabs: const [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 8,
                        children: [
                          Text('قائمة'),
                          Icon(Icons.format_list_bulleted, size: 20),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 8,
                        children: [
                          Text('بطاقات'),
                          Icon(Icons.view_carousel_outlined, size: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(children: [AzkarList(), AzkarSingle()]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
