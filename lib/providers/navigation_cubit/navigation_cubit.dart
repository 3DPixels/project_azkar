import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState());

  final List<String> pageNames = const [
    'Home',
    'Categories',
    'Other',
    'Settings',
  ];

  void changeMainIndex(int selectedIndex) {
    emit(NavigationState(mainIndex: selectedIndex));
  }

  void resetIndex() {
    emit(const NavigationState(mainIndex: 0));
  }
}
