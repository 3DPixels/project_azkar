import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_azkar/pages/mood_prayers/widgets/mood_prayer_card.dart';
import 'package:project_azkar/utils/formatters.dart';

class MoodDetails extends StatelessWidget {
  const MoodDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF101622),
      appBar: AppBar(
        backgroundColor: Color(0xF2101622),
        centerTitle: true,
        title: Text('أدعية مختارة'),
        toolbarHeight: 73,
        leadingWidth: 64,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Title
            Container(
              height: 248,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentGeometry.topCenter,
                  end: AlignmentGeometry.bottomCenter,
                  colors: [
                    Color(0xFF2B6CEE).withValues(alpha: 0.10),
                    Color(0xFF2B6CEE).withValues(alpha: 0.00),
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 12,
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Color(0xFF2B6CEE).withValues(alpha: .2),
                    foregroundColor: Color(0xFF2B6CEE),
                    child: Icon(Icons.cloud_off, size: 48),
                  ),
                  // SizedBox(height: 10),
                  Text(
                    'عند الشعور بالحزن',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontFamily: GoogleFonts.notoSansArabic().fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  // SizedBox(height: 10),
                  Text(
                    'أدعية للصبر و السكينة',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontFamily: GoogleFonts.notoSansArabic().fontFamily,
                      fontSize: 14,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF2B6CEE).withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                    child: Text(
                      '${12.toArabic()} دعاء',
                      style: TextStyle(color: Color(0xFF93C5FD), fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            // Body
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(spacing: 16, children: [MoodPrayerCard()]),
            ),
          ],
        ),
      ),
    );
  }
}
