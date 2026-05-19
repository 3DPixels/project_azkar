import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'home/home_page.dart';
import 'mood_page.dart';
import 'other_page.dart';
import 'prayers/prayers_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _tabs = const [
    HomePage(),
    PrayersPage(),
    MoodPage(),
    OtherPage(),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: 600,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: PageTransitionSwitcher(
              duration: const Duration(milliseconds: 700),
              // A fix for SingleChildScrollView weired snapping when navigating between pages
              layoutBuilder: (List<Widget> entries) {
                return Stack(
                  fit: StackFit.expand, // Forces children to fill the screen
                  children: entries,
                );
              },
              transitionBuilder: (child, animation, secondaryAnimation) {
                return FadeThroughTransition(
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  child: child,
                );
              },
              child: _tabs[_currentIndex],
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          _currentIndex = index;
          setState(() {});
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'الرئيسية'),
          NavigationDestination(icon: Icon(Icons.book), label: 'عبادات'),
          NavigationDestination(icon: Icon(Icons.mood), label: 'الحالة'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'الاعدادات'),
        ],
      ),
    );
  }
}
