import 'package:flutter/material.dart';
import 'package:project_azkar/pages/main_page.dart';
import 'package:reel_text/reel_text.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/formatters.dart';

class CompletionPage extends StatefulWidget {
  final int totalRead;

  const CompletionPage({super.key, required this.totalRead});

  @override
  State<CompletionPage> createState() => _CompletionPageState();
}

class _CompletionPageState extends State<CompletionPage> {
  int displayCount = 0;

  @override
  void initState() {
    super.initState();

    // We add a slight delay so the page has time to finish sliding in
    // before the numbers start rolling. This makes the animation pop!
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() {
          displayCount = widget.totalRead; // Jump to the target number
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('إتمام الأذكار')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              size: 100,
              color: AppColors.dsPrimary,
            ),
            const SizedBox(height: 24),
            const Text(
              'تقبل الله!',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: .center,
              children: [
                Text(
                  'لقد أتممت قراءة',
                  style: const TextStyle(fontSize: 18, color: Colors.white70),
                ),
                ReelText(
                  ' ${displayCount.toArabic()} ',
                  locale: Locale('ar'),
                  style: const TextStyle(fontSize: 18, color: Colors.white70),
                ),
                Text(
                  'من الأذكار',
                  style: const TextStyle(fontSize: 18, color: Colors.white70),
                ),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.dsPrimary,
                foregroundColor: Colors.white,
              ),
              child: const Text('العودة للرئيسية'),
            ),
          ],
        ),
      ),
    );
  }
}
