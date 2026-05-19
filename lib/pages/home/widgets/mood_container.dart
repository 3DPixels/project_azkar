import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../../mood_details.dart';

class MoodContainer extends StatelessWidget {
  final String title;
  final IconData? iconData;
  final Color iconColor;
  final Color? backgroundColor;

  const MoodContainer(
    this.title, {
    super.key,
    this.iconData,
    required this.iconColor,
    this.backgroundColor,
  });

  Color get _effectiveBackgroundColor {
    if (backgroundColor != null) return backgroundColor!;
    final hslColor = HSLColor.fromColor(iconColor);
    return hslColor.withSaturation(0.25).withLightness(0.15).toColor();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        OpenContainer(
          transitionDuration: const Duration(milliseconds: 500),
          closedColor: _effectiveBackgroundColor,
          // middleColor: Theme.of(context).scaffoldBackgroundColor,
          // openColor: Theme.of(context).scaffoldBackgroundColor,
          tappable: false,
          closedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          closedBuilder: (BuildContext context, VoidCallback openContainer) {
            return InkWell(
              onTap: openContainer,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: iconData != null
                    ? Icon(iconData, color: iconColor)
                    : const SizedBox.shrink(),
              ),
            );
          },
          openBuilder: (BuildContext context, VoidCallback _) {
            return const MoodDetails();
          },
        ),
        Text(title),
      ],
    );
  }
}
