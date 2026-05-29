import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class MoodContainer extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Widget detailsPage;
  final Color iconColor;
  final Color? backgroundColor;

  const MoodContainer({
    super.key,
    this.backgroundColor,
    required this.title,
    required this.iconData,
    required this.iconColor,
    required this.detailsPage,
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
          middleColor: Theme.of(context).scaffoldBackgroundColor,
          openColor: Theme.of(context).scaffoldBackgroundColor,
          tappable: false,
          closedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          closedBuilder: (BuildContext context, VoidCallback openContainer) {
            return InkWell(
              onTap: openContainer,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Icon(iconData, color: iconColor),
              ),
            );
          },
          openBuilder: (BuildContext context, VoidCallback _) {
            return detailsPage;
          },
        ),
        Text(title),
      ],
    );
  }
}
