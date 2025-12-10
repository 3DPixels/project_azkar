part of 'navigation_cubit.dart';

class NavigationState extends Equatable {
  final int mainIndex;

  const NavigationState({this.mainIndex = 0});

  @override
  List<Object> get props => [mainIndex];
}
