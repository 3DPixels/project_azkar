import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_azkar/data/dua_model.dart';

part 'azkar_state.dart';

class AzkarCubit extends Cubit<AzkarState> {
  AzkarCubit(List<DuaModel> initialSupplications)
    : super(AzkarState(items: [])) {
    // Initialize state mapping DuaModels to ZekrStateItems.
    final initialItems = initialSupplications
        .map(
          (dua) => ZekrStateItem(
            supplication: dua,
            targetCount: dua.count,
            currentCount: dua.count,
          ),
        )
        .toList();

    emit(AzkarState(items: initialItems));
  }

  void decrementCount(DuaModel supplication) {
    final updatedItems = state.items.map((item) {
      if (item.supplication == supplication && item.currentCount > 0) {
        return item.copyWith(currentCount: item.currentCount - 1);
      }
      return item;
    }).toList();
    emit(state.copyWith(items: updatedItems));
  }

  void undoCount(DuaModel supplication) {
    final updatedItems = state.items.map((item) {
      if (item.supplication == supplication) {
        return item.copyWith(currentCount: item.targetCount);
      }
      return item;
    }).toList();
    emit(state.copyWith(items: updatedItems));
  }

  void toggleList(bool showRead) {
    emit(state.copyWith(showReadList: showRead));
  }
}
