import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_azkar/utils/app_colors.dart';

import '../../../cubits/azkar/azkar_cubit.dart';
import '../../../data/dua_model.dart';
import 'azkar_list.dart';
import 'azkar_single.dart';
import 'completion_page.dart';
import 'custom_tab_bar.dart';
import 'daily_progress_indicator.dart';

class AzkarPage extends StatelessWidget {
  final String title;
  final List<DuaModel> allSupplications;

  const AzkarPage({
    super.key,
    required this.allSupplications,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AzkarCubit(allSupplications),
      child: BlocListener<AzkarCubit, AzkarState>(
        listenWhen: (previous, current) =>
            previous.unreadItems.isNotEmpty && current.unreadItems.isEmpty,
        listener: (context, state) {
          final sessionSum = state.readItems.fold(
            0,
            (sum, item) => sum + item.targetCount,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CompletionPage(totalRead: sessionSum),
            ),
          );
        },
        child: Scaffold(
          body: DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    toolbarHeight: 0,
                    expandedHeight: 170,
                    forceElevated: innerBoxIsScrolled,
                    scrolledUnderElevation: 0,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    flexibleSpace: FlexibleSpaceBar(
                      background: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            title,
                            textAlign: .center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    shape: Border(
                      bottom: BorderSide(
                        color: AppColors.primary.withValues(alpha: 0.15),
                      ),
                    ),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(130),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                          bottom: 16.0,
                        ),
                        child: Column(
                          spacing: 20,
                          children: [DailyProgressWidget(), CustomTabBar()],
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: const TabBarView(children: [AzkarList(), AzkarSingle()]),
            ),
          ),
        ),
      ),
    );
  }
}
