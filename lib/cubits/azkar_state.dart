part of 'azkar_cubit.dart';

// A wrapper to hold the mutable state of each Zekr (like current count)
class ZekrStateItem {
  final DuaModel supplication;
  final int targetCount;
  final int currentCount;

  ZekrStateItem({
    required this.supplication,
    required this.targetCount,
    required this.currentCount,
  });

  bool get isRead => currentCount == 0;

  ZekrStateItem copyWith({int? currentCount}) {
    return ZekrStateItem(
      supplication: supplication,
      targetCount: targetCount,
      currentCount: currentCount ?? this.currentCount,
    );
  }
}

class AzkarState {
  final List<ZekrStateItem> items;
  final bool showReadList; // Toggles between Unread/Read ChoiceChips

  AzkarState({required this.items, this.showReadList = false});

  // Derived properties for easy UI access
  List<ZekrStateItem> get unreadItems => items.where((e) => !e.isRead).toList();
  List<ZekrStateItem> get readItems => items.where((e) => e.isRead).toList();

  int get totalZekr => items.length;
  int get completedZekr => readItems.length;
  double get progress => totalZekr == 0 ? 0 : completedZekr / totalZekr;

  AzkarState copyWith({List<ZekrStateItem>? items, bool? showReadList}) {
    return AzkarState(
      items: items ?? this.items,
      showReadList: showReadList ?? this.showReadList,
    );
  }
}
