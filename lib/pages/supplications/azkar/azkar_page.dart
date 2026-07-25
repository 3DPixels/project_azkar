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
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  // COMBINED: Everything is now securely in ONE SliverAppBar
                  SliverAppBar(
                    title: Text(title),
                    floating: true,
                    // snap: true,
                    pinned: false,
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(130),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                          bottom: 16.0,
                        ),
                        child: Column(
                          children: [
                            // --- Shared Progress Section ---
                            BlocBuilder<AzkarCubit, AzkarState>(
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('التقدم اليومي'),
                                        Text(
                                          '${state.completedZekr}/${state.totalZekr}',
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    TweenAnimationBuilder<double>(
                                      tween: Tween<double>(
                                        begin: 0,
                                        end: state.progress,
                                      ),
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeInOut,
                                      builder: (context, animatedValue, child) {
                                        return LinearProgressIndicator(
                                          value: animatedValue,
                                          backgroundColor:
                                              AppColors.darkSurface,
                                          color: AppColors.primary,
                                          minHeight: 6,
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                            // --- Shared TabBar ---
                            Container(
                              height: 48,
                              decoration: BoxDecoration(
                                color: AppColors.darkSurface,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TabBar(
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicatorPadding: const EdgeInsets.all(4),
                                overlayColor: WidgetStateProperty.all(
                                  Colors.transparent,
                                ),
                                dividerColor: Colors.transparent,
                                splashBorderRadius: BorderRadius.circular(8),
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.secondary,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: .05,
                                      ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      spacing: 8,
                                      children: [
                                        Text('قائمة'),
                                        Icon(
                                          Icons.format_list_bulleted,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Tab(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      spacing: 8,
                                      children: [
                                        Text('بطاقات'),
                                        Icon(
                                          Icons.view_carousel_outlined,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: const TabBarView(
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
          ),
        ),
      ),
    );
  }
}
