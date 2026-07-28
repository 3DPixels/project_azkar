import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_azkar/utils/app_colors.dart';

import '../../../cubits/azkar/azkar_cubit.dart';
import '../../../data/dua_model.dart';
import '../../../widgets/dua_card.dart';

class TestPage extends StatelessWidget {
  final String title;
  final List<DuaModel> allSupplications;

  const TestPage({
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
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => CompletionPage(totalRead: sessionSum),
          //   ),
          // );
        },
        child: Scaffold(
          body: DefaultTabController(
            length: 2,
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
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // Adjust to your theme
                              ),
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
                      // Adjust this height based on the total height of your progress + tabbar
                      preferredSize: const Size.fromHeight(130),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  CustomScrollView(
                    key: const PageStorageKey<String>('list_tab'),
                    slivers: [
                      // Filter Chips
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 12.0,
                          ),
                          child: Row(
                            spacing: 12,
                            children: [
                              ChoiceChip(
                                label: const Text('أذكار باقية'),
                                selected: false,
                                onSelected: (val) => context
                                    .read<AzkarCubit>()
                                    .toggleList(false),
                                selectedColor: AppColors.primary.withValues(
                                  alpha: 0.2,
                                ),
                                checkmarkColor: AppColors.primary,
                                backgroundColor: AppColors.darkSurface,
                              ),
                              ChoiceChip(
                                label: const Text('تمت قراءتها'),
                                selected: true,
                                onSelected: (val) =>
                                    context.read<AzkarCubit>().toggleList(true),
                                selectedColor: AppColors.primary.withValues(
                                  alpha: 0.2,
                                ),
                                checkmarkColor: AppColors.primary,
                                backgroundColor: AppColors.darkSurface,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Dua Cards List
                      SliverList.builder(
                        itemCount: allSupplications.length,
                        itemBuilder: (context, index) {
                          final item = allSupplications[index];
                          return DuaCard(
                            key: ValueKey(item.dua),
                            supplication: item,
                            buttonsColor: AppColors.primary,
                            borderColor: AppColors.primary.withValues(
                              alpha: 0.15,
                            ),
                            bottomColor: AppColors.darkNavBarBackground,
                            containerBackgroundColor: AppColors.darkSurface,
                            enableCounter: true,
                            currentCount: 3,
                            targetCount: 3,
                            // onTap: () => context.read<AzkarCubit>().decrementCount(
                            //   item.supplication,
                            // ),
                            // onUndo: () => context.read<AzkarCubit>().undoCount(
                            //   item.supplication,
                            // ),
                            // onSkip: () => context.read<AzkarCubit>().skipZekr(
                            //   item.supplication,
                            // ),
                          );
                        },
                      ),
                    ],
                  ),

                  // TAB 2: Single View Column
                  const Center(child: Text('Single View Placeholder')),
                ],
              ),
              // slivers: [
              //   // 1. Title AppBar (Disappears on scroll, only shows at top)
              //   SliverAppBar(
              //     title: Text(title),
              //     floating: false,
              //     pinned: false,
              //   ),

              //   // 2. Progress & TabBar (Floats and snaps back on slight upward scroll)
              //   SliverAppBar(
              //     floating: true,
              //     snap: true,
              //     pinned: false,
              //     automaticallyImplyLeading:
              //         false, // Prevents duplicate back buttons
              //     toolbarHeight: 0,
              //     bottom: PreferredSize(
              //       // Adjust this height based on the total height of your progress + tabbar
              //       preferredSize: const Size.fromHeight(130),
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //         child: Column(
              //           children: [
              //             // --- Shared Progress Section ---
              //             BlocBuilder<AzkarCubit, AzkarState>(
              //               builder: (context, state) {
              //                 return Column(
              //                   children: [
              //                     Row(
              //                       mainAxisAlignment:
              //                           MainAxisAlignment.spaceBetween,
              //                       children: [
              //                         const Text('التقدم اليومي'),
              //                         Text(
              //                           '${state.completedZekr}/${state.totalZekr}',
              //                         ),
              //                       ],
              //                     ),
              //                     const SizedBox(height: 8),
              //                     TweenAnimationBuilder<double>(
              //                       tween: Tween<double>(
              //                         begin: 0,
              //                         end: state.progress,
              //                       ),
              //                       duration: const Duration(milliseconds: 300),
              //                       curve: Curves.easeInOut,
              //                       builder: (context, animatedValue, child) {
              //                         return LinearProgressIndicator(
              //                           value: animatedValue,
              //                           backgroundColor: AppColors.darkSurface,
              //                           color: AppColors.primary,
              //                           minHeight: 6,
              //                           borderRadius: BorderRadius.circular(4),
              //                         );
              //                       },
              //                     ),
              //                   ],
              //                 );
              //               },
              //             ),
              //             const SizedBox(height: 20),
              //             // --- Shared TabBar ---
              //             Container(
              //               height: 48,
              //               decoration: BoxDecoration(
              //                 color: AppColors.darkSurface,
              //                 borderRadius: BorderRadius.circular(12),
              //               ),
              //               child: TabBar(
              //                 indicatorSize: TabBarIndicatorSize.tab,
              //                 indicatorPadding: const EdgeInsets.all(4),
              //                 overlayColor: WidgetStateProperty.all(
              //                   Colors.transparent,
              //                 ),
              //                 dividerColor: Colors.transparent,
              //                 splashBorderRadius: BorderRadius.circular(8),
              //                 indicator: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(8),
              //                   color: AppColors.secondary,
              //                   boxShadow: [
              //                     BoxShadow(
              //                       color: Colors.black.withValues(alpha: .05),
              //                       blurRadius: 4,
              //                       offset: const Offset(0, 2),
              //                     ),
              //                   ],
              //                 ),
              //                 labelColor: Colors.white,
              //                 unselectedLabelColor: AppColors.neutral,
              //                 tabs: const [
              //                   Tab(
              //                     child: Row(
              //                       mainAxisAlignment: MainAxisAlignment.center,
              //                       spacing: 8,
              //                       children: [
              //                         Text('قائمة'),
              //                         Icon(
              //                           Icons.format_list_bulleted,
              //                           size: 20,
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                   Tab(
              //                     child: Row(
              //                       mainAxisAlignment: MainAxisAlignment.center,
              //                       spacing: 8,
              //                       children: [
              //                         Text('بطاقات'),
              //                         Icon(
              //                           Icons.view_carousel_outlined,
              //                           size: 20,
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),

              //   // 3. Choice Chips Row
              //   SliverToBoxAdapter(
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(
              //         horizontal: 16.0,
              //         vertical: 12.0,
              //       ),
              //       child: Row(
              //         spacing: 12,
              //         children: [
              //           ChoiceChip(
              //             label: const Text('أذكار باقية'),
              //             selected: false,
              //             onSelected: (val) =>
              //                 context.read<AzkarCubit>().toggleList(false),
              //             selectedColor: AppColors.primary.withValues(
              //               alpha: 0.2,
              //             ),
              //             checkmarkColor: AppColors.primary,
              //             backgroundColor: AppColors.darkSurface,
              //           ),
              //           ChoiceChip(
              //             label: const Text('تمت قراءتها'),
              //             selected: true,
              //             onSelected: (val) =>
              //                 context.read<AzkarCubit>().toggleList(true),
              //             selectedColor: AppColors.primary.withValues(
              //               alpha: 0.2,
              //             ),
              //             checkmarkColor: AppColors.primary,
              //             backgroundColor: AppColors.darkSurface,
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),

              //   // 4. Dua Cards List
              //   SliverList.builder(
              //     itemCount: allSupplications.length,
              //     itemBuilder: (context, index) {
              //       final item = allSupplications[index];
              //       return DuaCard(
              //         key: ValueKey(item.dua),
              //         supplication: item,
              //         buttonsColor: AppColors.primary,
              //         borderColor: AppColors.primary.withValues(alpha: 0.15),
              //         bottomColor: AppColors.darkNavBarBackground,
              //         containerBackgroundColor: AppColors.darkSurface,
              //         enableCounter: true,
              //         currentCount: 3,
              //         targetCount: 3,
              //         // onTap: () => context.read<AzkarCubit>().decrementCount(
              //         //   item.supplication,
              //         // ),
              //         // onUndo: () => context.read<AzkarCubit>().undoCount(
              //         //   item.supplication,
              //         // ),
              //         // onSkip: () => context.read<AzkarCubit>().skipZekr(
              //         //   item.supplication,
              //         // ),
              //       );
              //     },
              //   ),
              // ],
            ),
          ),
        ),
      ),
    );
  }
}
