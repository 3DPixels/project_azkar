import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../providers/navigation_cubit/navigation_cubit.dart';
import 'categories_page.dart';
import 'home_page.dart';
import 'mood_page.dart';
import 'other_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  final List<Widget> _tabs = const [
    HomePage(),
    CategoriesPage(),
    MoodPage(),
    OtherPage(),
  ];

  @override
  Widget build(BuildContext context) {
    // context.watch() rebuilds the widget when the state changes.
    final navCubit = context.watch<NavigationCubit>();
    final navState = navCubit.state;

    return Scaffold(
      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 700),
        transitionBuilder: (child, animation, secondaryAnimation) {
          return FadeThroughTransition(
            // fillColor: Theme.of(context).scaffoldBackgroundColor,
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: _tabs[navState.mainIndex],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: navState.mainIndex,
        onDestinationSelected: (index) {
          context.read<NavigationCubit>().changeMainIndex(index);
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
