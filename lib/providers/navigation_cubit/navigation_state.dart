part of 'navigation_cubit.dart';

// Using Equatable to prevent unnecessary rebuilds if the index is the same.
class NavigationState extends Equatable {
  final int mainIndex;

  const NavigationState({this.mainIndex = 0});

  @override
  List<Object> get props => [mainIndex];
}
