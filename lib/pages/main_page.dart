import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:project_azkar/pages/settings/view.dart';
import 'package:project_azkar/pages/supplications/view.dart';

import 'home/view.dart';
import 'prayers/view.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  late PageController _pageController;

  // We wrap the pages in our custom KeepAlivePage wrapper to prevent state resets.
  final List<Widget> _tabs = const [
    KeepAlivePage(child: HomePage()),
    PrayersPage(),
    SupplicationsPage(),
    SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the starting index
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    // Always dispose controllers to prevent memory leaks
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: 600,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: _tabs,
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
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

/// A simple wrapper widget that forces its child to stay alive
/// even when it scrolls off-screen in a PageView.
class KeepAlivePage extends StatefulWidget {
  final Widget child;

  const KeepAlivePage({super.key, required this.child});

  @override
  State<KeepAlivePage> createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  // Setting this to true tells Flutter not to destroy the widget
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // This super call is required for the mixin to work correctly
    super.build(context);
    return widget.child;
  }
}
