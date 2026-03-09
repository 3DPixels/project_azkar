import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import 'categories_page.dart';
import 'home_page.dart';
import 'mood_page.dart';
import 'other_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _tabs = const [
    HomePage(),
    CategoriesPage(),
    MoodPage(),
    OtherPage(),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: PageTransitionSwitcher(
            duration: const Duration(milliseconds: 700),
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
          NavigationDestination(icon: Icon(Icons.menu), label: 'اخرى'),
        ],
      ),
    );
  }
}
