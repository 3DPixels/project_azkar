import 'package:flutter/material.dart';

import 'about_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('الرئيسية')),
      body: Center(
        child: FilledButton(
          onPressed: () async {},
          child: Text('Send Notification'),
        ),
      ),
    );
  }
}
