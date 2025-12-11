import 'package:flutter/material.dart';
import 'package:project_azkar/data/zekr_model.dart';
import 'package:project_azkar/data/zekr_repo.dart';

class AzkarPage extends StatelessWidget {
  const AzkarPage({super.key, required this.time, required this.categories});
  final ZekrTime time;
  final Categories categories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          final List<ZekrModel> azkar = ZekrRepository.getAzkarByTime(time);
          return Card(
            child: Text(azkar[index].zekr, style: TextStyle(fontSize: 22)),
          );
        },
      ),
    );
  }
}
