import 'package:flutter/material.dart';
import 'package:project_azkar/data/mood_model.dart';
import 'package:project_azkar/data/mood_supplications_repo.dart';
import 'package:project_azkar/widgets/dua_card.dart';
import 'package:project_azkar/utils/formatters.dart';

import '../../../utils/app_fonts.dart';

class MoodsList extends StatefulWidget {
  final MoodModel mood;

  const MoodsList(this.mood, {super.key});

  @override
  State<MoodsList> createState() => _MoodsListState();
}

class _MoodsListState extends State<MoodsList> {
  late ScrollController _scrollController;
  bool _isCollapsed = false;

  final double _expandedHeight = 248.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        // We add a 50px buffer so the transition starts right before it fully snaps
        if (_scrollController.hasClients) {
          bool isCollapsed =
              _scrollController.offset >
              (_expandedHeight - kToolbarHeight - 50);
          if (_isCollapsed != isCollapsed) {
            setState(() {
              _isCollapsed = isCollapsed;
            });
          }
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final supplications = MoodSupplicationsRepo.getSupplicationByCategory(
      widget.mood.category,
    );

    return Scaffold(
      backgroundColor: widget.mood.colorPalette.backgroundColor,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: _expandedHeight,
            toolbarHeight: 73,
            leadingWidth: 64,
            pinned: true,
            // Transparent when expanded for a seamless look, solid when collapsed
            // backgroundColor: _isCollapsed
            //     ? widget.mood.colorPalette.backgroundColor.withValues(
            //         alpha: .95,
            //       )
            //     : Colors.transparent,
            elevation: 0,
            centerTitle: true,
            // Fade in the title only when collapsed
            title: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: _isCollapsed ? 1.0 : 0.0,
              child: Text(widget.mood.title),
            ),
            // Fade in the action icon only when collapsed
            actions: [
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _isCollapsed ? 1.0 : 0.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Icon(
                    widget.mood.icon,
                    color: widget.mood.colorPalette.mainColor,
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: AlignmentGeometry.topCenter,
                    end: AlignmentGeometry.bottomCenter,
                    colors: [
                      widget.mood.colorPalette.mainColor.withValues(
                        alpha: 0.10,
                      ),
                      widget.mood.colorPalette.mainColor.withValues(
                        alpha: 0.00,
                      ),
                    ],
                  ),
                ),
                // SafeArea prevents your custom column from clipping into the status bar
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 12,
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: widget.mood.colorPalette.mainColor
                            .withValues(alpha: .2),
                        foregroundColor: widget.mood.colorPalette.mainColor,
                        child: Icon(widget.mood.icon, size: 48),
                      ),
                      Text(
                        widget.mood.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontFamily: AppFonts.notoSans,
                        ),
                      ),
                      Text(
                        widget.mood.subtitle,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontFamily: AppFonts.notoSans,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: widget.mood.colorPalette.mainColor.withValues(
                            alpha: 0.10,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 10,
                        ),
                        child: Text(
                          '${supplications.length.toArabic()} دعاء',
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(
                                color: widget.mood.colorPalette.badgeTextColor,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Body List
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            // SliverList.separated natively replaces the Column with spacing you had
            sliver: SliverList.separated(
              itemCount: supplications.length,
              itemBuilder: (context, index) {
                final sup = supplications[index];
                return DuaCard(
                  supplication: sup,
                  buttonsColor: widget.mood.colorPalette.mainColor,
                  borderColor: widget.mood.colorPalette.borderColor,
                  bottomColor: widget.mood.colorPalette.cardBottomColor,
                  containerBackgroundColor:
                      widget.mood.colorPalette.cardBackgroundColor,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 16),
            ),
          ),

          // Bottom padding for a better scrolling experience
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
