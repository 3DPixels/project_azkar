import 'package:flutter/material.dart';
import 'package:project_azkar/services/cache_helper.dart';
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
  late int globalCount;

  @override
  void initState() {
    super.initState();
    // 1. Get the current global total BEFORE adding today's session
    globalCount = CacheHelper.getAzkarCount();

    // 2. Calculate the new lifetime total
    final newLifetimeTotal = globalCount + widget.totalRead;

    // 3. Cache it in the background immediately
    CacheHelper.cacheAzkarCount(newLifetimeTotal);

    // 4. Wait for page transition, then trigger ReelText animation
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          globalCount = newLifetimeTotal;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              size: 100,
              color: AppColors.primary,
            ),
            const SizedBox(height: 24),
            const Text(
              'تقبل الله!',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'لقد قرأت اليوم ${widget.totalRead.toArabic()} من الأذكار',
              style: const TextStyle(fontSize: 18, color: Colors.white70),
            ),
            const SizedBox(height: 16),
            // The animated global count
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'مجموع أذكارك الكلي: ',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                ReelText(
                  // Isolating the number in ReelText prevents Arabic text bugs
                  globalCount.toArabic(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
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
