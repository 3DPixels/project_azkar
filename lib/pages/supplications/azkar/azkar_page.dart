import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_azkar/utils/app_colors.dart';

import '../../../cubits/azkar/azkar_cubit.dart';
import '../../../data/dua_model.dart';
import 'azkar_list.dart';
import 'azkar_single.dart';
import 'completion_page.dart';

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
          // Navigate to the completion page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CompletionPage(totalRead: state.totalZekr),
            ),
          );
        },
        child: Scaffold(
          appBar: AppBar(title: Text(title)),
          body: DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Column(
              spacing: 32,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.darkSurface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: EdgeInsetsGeometry.all(4),
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    dividerColor: Colors.transparent,
                    splashBorderRadius: BorderRadius.circular(8),
                    // The sliding pill
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.secondary,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: .05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: AppColors.neutral,
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
                  child: TabBarView(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: AzkarList(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: AzkarSingle(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
