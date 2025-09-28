import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  // Initialize with the default state (index 0).
  NavigationCubit() : super(const NavigationState());

  // Page names can live here as they are related to navigation logic.
  final List<String> pageNames = const [
    'Home',
    'Categories',
    'Other',
    'Settings',
  ];

  void changeMainIndex(int selectedIndex) {
    // Emit a new state instance with the new index.
    emit(NavigationState(mainIndex: selectedIndex));
  }

  void resetIndex() {
    emit(const NavigationState(mainIndex: 0));
  }
}
