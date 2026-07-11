import 'package:flutter/material.dart';

import '../../../data/dua_model.dart';

class DuaCard extends StatefulWidget {
  final DuaModel supplication;
  final Color buttonsColor;
  final Color borderColor;
  final Color bottomColor;
  final Color containerBackgroundColor;

  // Optional parameters for counting functionality
  final bool enableCounter;
  final int currentCount;
  final int targetCount;
  final VoidCallback? onTap;
  final VoidCallback? onUndo;

  const DuaCard({
    super.key,
    required this.supplication,
    required this.buttonsColor,
    required this.borderColor,
    required this.bottomColor,
    required this.containerBackgroundColor,
    this.enableCounter = false,
    this.currentCount = 0,
    this.targetCount = 0,
    this.onTap,
    this.onUndo,
  });

  @override
  State<DuaCard> createState() => _DuaCardState();
}

class _DuaCardState extends State<DuaCard> {
  bool playing = false;
  final iconsColor = const Color(0xFF94A3B8);

  @override
  Widget build(BuildContext context) {
    // Only allow tapping the container if the counter is enabled and count > 0
    final bool canTap = widget.enableCounter && widget.currentCount > 0;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: canTap ? widget.onTap : null,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: BoxBorder.all(color: widget.borderColor),
            color: widget.containerBackgroundColor,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton.filled(
                      onPressed: () {
                        setState(() {
                          playing = !playing;
                        });
                      },
                      iconSize: 35,
                      style: IconButton.styleFrom(
                        backgroundColor: widget.buttonsColor.withValues(
                          alpha: .1,
                        ),
                        foregroundColor: widget.buttonsColor,
                      ),
                      icon: Icon(
                        playing ? Icons.pause : Icons.play_arrow_outlined,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          Text(
                            widget.supplication.dua,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontFamily: 'NotoSansArabicVar'),
                          ),
                          Divider(thickness: 1, color: widget.borderColor),
                          Text(
                            widget.supplication.benefit,
                            textDirection: TextDirection.ltr,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge?.copyWith(color: iconsColor),
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              foregroundColor: widget.buttonsColor,
                              textStyle: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    fontFamily: 'NotoSansArabicVar',
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            label: Text(widget.supplication.source),
                            icon: const Icon(Icons.menu_book),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(24),
                  ),
                  border: BorderDirectional(
                    top: BorderSide(color: widget.borderColor),
                  ),
                  color: widget.bottomColor,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border),
                      color: iconsColor,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.copy_rounded),
                      color: iconsColor,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.share),
                      color: iconsColor,
                    ),
                    const Spacer(),

                    // The 3 States Logic
                    if (!widget.enableCounter)
                      // State 1: Counter disabled (Standard view for rest of app)
                      Text(
                        'Dua #1',
                        style: TextStyle(
                          color: iconsColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      )
                    else if (widget.currentCount == 0)
                      // State 3: Counter enabled, but count is 0 (Show Undo)
                      TextButton.icon(
                        onPressed: widget.onUndo,
                        icon: const Icon(Icons.undo),
                        label: const Text('تراجع'),
                        style: TextButton.styleFrom(
                          foregroundColor: widget.buttonsColor,
                        ),
                      )
                    else
                      // State 2: Counter enabled, count > 0 (Show Progress)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: widget.buttonsColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${widget.currentCount} / ${widget.targetCount}',
                          style: TextStyle(
                            color: widget.buttonsColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
