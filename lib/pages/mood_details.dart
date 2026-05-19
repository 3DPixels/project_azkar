import 'package:flutter/material.dart';

class MoodDetails extends StatelessWidget {
  const MoodDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('سعيد', style: Theme.of(context).textTheme.headlineMedium),
            CircleAvatar(radius: 40, child: Icon(Icons.sunny, size: 40)),
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Card(color: Colors.red),
            ),
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Card(color: Colors.red),
            ),
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Card(color: Colors.red),
            ),
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Card(color: Colors.red),
            ),
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Card(color: Colors.red),
            ),
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Card(color: Colors.red),
            ),
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Card(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
