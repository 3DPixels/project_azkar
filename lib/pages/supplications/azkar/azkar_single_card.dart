import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:share_plus/share_plus.dart';

import '../../../data/dua_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';

class AzkarSingleCard extends StatefulWidget {
  final DuaModel supplication;

  const AzkarSingleCard({super.key, required this.supplication});

  @override
  State<AzkarSingleCard> createState() => _AzkarSingleCardState();
}

class _AzkarSingleCardState extends State<AzkarSingleCard> {
  bool isPlaying = false;
  bool isAutoPlay = false;
  double playSpeed = 1.0;

  final iconsColor = const Color(0xFF94A3B8);

  void _toggleSpeed() {
    setState(() {
      if (playSpeed == 1.0) {
        playSpeed = 1.25;
      } else if (playSpeed == 1.25) {
        playSpeed = 1.5;
      } else if (playSpeed == 1.5) {
        playSpeed = 2.0;
      } else {
        playSpeed = 1.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.darkSurface,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.15),
            ),
          ),
          child: Column(
            children: [
              // Scrollable Content Area (Dua + Benefit + Source)
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        widget.supplication.dua,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontFamily: AppFonts.notoSans,
                          height: 1.8,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Divider(
                        thickness: 1,
                        color: AppColors.primary.withValues(alpha: 0.15),
                      ),
                      const SizedBox(height: 12),
                      if (widget.supplication.benefit.isNotEmpty) ...[
                        Text(
                          widget.supplication.benefit,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: iconsColor, height: 1.6),
                        ),
                        const SizedBox(height: 12),
                      ],
                      TextButton.icon(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          textStyle: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontFamily: AppFonts.notoSans,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        label: Text(widget.supplication.source),
                        icon: const Icon(Icons.menu_book, size: 18),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Toolbar (Copy, Share, Play, Speed, AutoPlay)
              Container(
                decoration: BoxDecoration(
                  color: AppColors.darkNavBarBackground,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(28),
                  ),
                  border: BorderDirectional(
                    top: BorderSide(
                      color: AppColors.primary.withValues(alpha: 0.15),
                    ),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          tooltip: 'نسخ',
                          onPressed: () async {
                            await Clipboard.setData(
                              ClipboardData(text: widget.supplication.dua),
                            );
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Row(
                                  spacing: 10,
                                  children: [
                                    Icon(Icons.copy_rounded),
                                    Text(
                                      "تم نسخ الدعاء",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                backgroundColor: AppColors.darkNavBarBackground,
                                duration: Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          icon: const Icon(Icons.copy_rounded),
                          color: iconsColor,
                        ),
                        IconButton(
                          tooltip: 'مشاركة',
                          onPressed: () {
                            String textToShare =
                                '\u200F${widget.supplication.dua} - ${widget.supplication.benefit}';
                            SharePlus.instance.share(
                              ShareParams(
                                title: 'Dua share',
                                text: textToShare,
                              ),
                            );
                          },
                          icon: const Icon(Icons.share),
                          color: iconsColor,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: _toggleSpeed,
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            child: Text(
                              '${playSpeed == playSpeed.toInt() ? playSpeed.toInt() : playSpeed}x',
                              style: TextStyle(
                                color: playSpeed > 1.0
                                    ? AppColors.primary
                                    : iconsColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          tooltip: 'تشغيل تلقائي',
                          onPressed: () {
                            setState(() {
                              isAutoPlay = !isAutoPlay;
                            });
                          },
                          icon: Icon(
                            isAutoPlay
                                ? Icons.autorenew_rounded
                                : Icons.sync_disabled_rounded,
                          ),
                          color: isAutoPlay ? AppColors.primary : iconsColor,
                        ),
                        IconButton.filled(
                          onPressed: () {
                            setState(() {
                              isPlaying = !isPlaying;
                            });
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.primary.withValues(
                              alpha: 0.15,
                            ),
                            foregroundColor: AppColors.primary,
                          ),
                          icon: Icon(
                            isPlaying
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 300.ms, curve: Curves.easeOut)
        .scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1.0, 1.0),
          duration: 300.ms,
          curve: Curves.easeOut,
        );
  }
}
