import 'package:flutter/material.dart';
import 'package:project_azkar/utils/app_images.dart';

class PrayerDetails extends StatefulWidget {
  const PrayerDetails({super.key});

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
              child: const Text(
                'فضل صلاة الجنازة',
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
                  Image.asset("assets/images/prayer2.png", fit: BoxFit.cover),
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
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF425A38),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'فضلها',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.access_time,
                              color: Colors.white70,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              '٢ دقيقة',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'فضل صلاة الجنازة',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'صلاة الجنازة فرض كفاية، ولها أجر عظيم، وهي دعاء للميت بالرحمة والمغفرة، وتذكير للحي بالمصير المحتوم.',
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

  @override
  Widget build(BuildContext context) {
    // IntrinsicHeight allows the vertical line to stretch exactly to the height of the card
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline Indicator Column
          SizedBox(
            width: 40,
            child: Column(
              children: [
                // Top line segment (hidden on first item)
                Container(
                  height: 24,
                  width: 1,
                  color: index == 0
                      ? Colors.transparent
                      : const Color(0xFF333333),
                ),
                // Number Circle
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF333333)),
                    color: const Color(0xFF1E1E1E),
                  ),
                  alignment: Alignment.center,
                  // Using Arabic numerals based on index
                  child: Text(
                    index == 0 ? '١' : '٢',
                    style: const TextStyle(
                      color: Color(0xFF7A9F63),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Bottom line segment (stretches to fill space, hidden on last item)
                Expanded(
                  child: Container(
                    width: 1,
                    color: isLast
                        ? Colors.transparent
                        : const Color(0xFF333333),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          // Card Content
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
                    // Card Header Row
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
                        Icon(
                          index == 0
                              ? Icons.pan_tool_outlined
                              : Icons.favorite_border,
                          color: const Color(0xFF5A6C49),
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF9E9E9E),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Inner Quote/Dua Container
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
                          fontSize: 16,
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
