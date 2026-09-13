import 'package:flutter/material.dart';
import 'package:project_azkar/data/models/prayer_model.dart';

class PrayerDetails extends StatefulWidget {
  final PrayerModel prayer;
  const PrayerDetails(this.prayer, {super.key});

  @override
  State<PrayerDetails> createState() => _PrayerDetailsState();
}

class _PrayerDetailsState extends State<PrayerDetails> {
  late ScrollController _scrollController;
  bool _isCollapsed = false;
  final double _expandedHeight = 300.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.hasClients) {
          bool isCollapsed =
              _scrollController.offset >
              (_expandedHeight - kToolbarHeight - 30);
          if (_isCollapsed != isCollapsed) {
            setState(() => _isCollapsed = isCollapsed);
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
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: _expandedHeight,
            pinned: true,
            stretch: true,
            backgroundColor: const Color(0xFF101010),
            title: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: _isCollapsed ? 1.0 : 0.0,
              child: Text(
                'كيفية ${widget.prayer.title}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.blurBackground,
                StretchMode.zoomBackground,
                StretchMode.fadeTitle,
              ],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(widget.prayer.imagePath, fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.6),
                          const Color(0xFF101010),
                        ],
                        stops: const [0.3, 0.8, 1.0],
                      ),
                    ),
                  ),
                  // Header Content Container
                  Positioned(
                    bottom: 24,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tags Row
                        Row(
                          children: [
                            if (widget.prayer.chipText != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF425A38),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  widget.prayer.chipText!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            const SizedBox(width: 8),
                            if (widget.prayer.chipText != null &&
                                widget.prayer.hintText != null)
                              const Icon(
                                Icons.access_time,
                                color: Colors.white70,
                                size: 16,
                              ),
                            const SizedBox(width: 4),
                            if (widget.prayer.chipText != null &&
                                widget.prayer.hintText != null)
                              Text(
                                widget.prayer.hintText!,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'فضل ${widget.prayer.title}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.prayer.subtitle,
                          style: TextStyle(
                            color: Color(0xFFB0B0B0),
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Section Header (Steps)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'خطوات الصلاة',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF2C3E21)),
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF161F12),
                    ),
                    child: const Text(
                      '٤ تكبيرات',
                      style: TextStyle(color: Color(0xFF7A9F63), fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Stepper List
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return StepTile(
                    index: index,
                    isLast:
                        index == 1, // Set to index == 3 if you add all 4 steps
                    title: index == 0 ? 'التكبيرة الأولى' : 'التكبيرة الثانية',
                    subtitle: index == 0
                        ? 'يقرأ بعد التكبيرة الأولى سورة الفاتحة سراً.'
                        : 'يصلى على النبي ﷺ الصلاة الإبراهيمية.',
                    innerText: index == 0
                        ? 'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ ۝ الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ ۝ الرَّحْمَنِ الرَّحِيمِ ۝ مَالِكِ يَوْمِ الدِّينِ'
                        : 'اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ، كَمَا صَلَّيْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ، إِنَّكَ حَمِيدٌ مَجِيدٌ',
                  );
                },
                childCount: 9, // Adjust to 4 for all steps
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}

/// A custom timeline widget that uses IntrinsicHeight to draw the connecting line
/// without needing third-party packages.
class StepTile extends StatelessWidget {
  final int index;
  final bool isLast;
  final String title;
  final String subtitle;
  final String innerText;

  const StepTile({
    super.key,
    required this.index,
    required this.isLast,
    required this.title,
    required this.subtitle,
    required this.innerText,
  });

  // Converts 1, 2, 3, 4 to Arabic numerals
  String _toArabicIndic(int number) {
    const arabicDigits = ['١', '٢', '٣', '٤'];
    return arabicDigits[number - 1];
  }

  @override
  Widget build(BuildContext context) {
    // Colors matching the green stepper in the image
    const lineColor = Color(0xFF2E4326);
    const greenBorderColor = Color(0xFF4C6B3E);
    const numberColor = Color(0xFF88B06F);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Timeline Indicator Column
          SizedBox(
            width: 40,
            child: Column(
              children: [
                // Green-bordered Circle
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: greenBorderColor, width: 1.5),
                    color: const Color(0xFF141C11),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _toArabicIndic(index + 1),
                    style: const TextStyle(
                      color: numberColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Connecting Line (Fades out on the last item)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      gradient: isLast
                          ? const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                lineColor,
                                Colors
                                    .transparent, // Fades out smoothly at the bottom
                              ],
                            )
                          : null,
                      color: isLast ? null : lineColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          // 2. Step Card Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF262626)),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.play_circle_outline,
                          color: Color(0xFF6B8399),
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF9E9E9E),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF242424),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        innerText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          height: 1.8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
