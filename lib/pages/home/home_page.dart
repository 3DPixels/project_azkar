import 'package:flutter/material.dart';

import 'summary_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('السلام عليكم', style: Theme.of(context).textTheme.titleLarge),
            Text('ربيع الاول، 1447'),
          ],
        ),
        // Prayer card
        SummaryCard(),
      ],
    );
  }
}
