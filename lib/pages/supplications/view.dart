import 'package:flutter/material.dart';
import 'package:project_azkar/data/zekr_repo.dart';
import 'package:project_azkar/widgets/dua_card.dart';

class SupplicationsPage extends StatelessWidget {
  const SupplicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('supplication')),
      body: ListWheelScrollView(
        itemExtent: 50,
        offAxisFraction: -1,
        overAndUnderCenterOpacity: .5,
        children: List.generate(
          30,
          (index) => Text(
            'Option: $index',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
