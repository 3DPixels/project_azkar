import 'package:flutter/material.dart';
import 'package:project_azkar/data/dua_model.dart';

class MoodPrayerCard extends StatefulWidget {
  final DuaModel supplication;
  final Color buttonsColor;
  final Color borderColor;
  final Color bottomColor;
  final Color containerBackgroundColor;

  const MoodPrayerCard({
    super.key,
    required this.supplication,
    required this.buttonsColor,
    required this.borderColor,
    required this.bottomColor,
    required this.containerBackgroundColor,
  });

  @override
  State<MoodPrayerCard> createState() => _MoodPrayerCardState();
}

class _MoodPrayerCardState extends State<MoodPrayerCard> {
  bool playing = false;
  final iconsColor = Color(0xFF94A3B8);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    backgroundColor: widget.buttonsColor.withValues(alpha: .1),
                    foregroundColor: widget.buttonsColor,
                  ),
                  icon: Icon(playing ? Icons.pause : Icons.play_arrow_outlined),
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
                        icon: Icon(Icons.menu_book),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
              border: BorderDirectional(
                top: BorderSide(color: widget.borderColor),
              ),
              color: widget.bottomColor,
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_border),
                  color: iconsColor,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.copy_rounded),
                  color: iconsColor,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.share),
                  color: iconsColor,
                ),
                Spacer(),
                Text(
                  'Dua #1',
                  style: TextStyle(
                    color: iconsColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
