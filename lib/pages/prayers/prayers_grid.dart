import 'package:flutter/material.dart';

class PrayersGrid extends StatelessWidget {
  const PrayersGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        children: [PrayerCard(), PrayerCard(), PrayerCard(), PrayerCard()],
      ),
    );
  }
}

class PrayerCard extends StatelessWidget {
  const PrayerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blueGrey,
            child: Icon(Icons.compass_calibration),
          ),
          Text('صلاة الاستخارة', style: TextStyle(fontSize: 20)),
          Text('دعاء و توجية'),
        ],
      ),
    );
  }
}
