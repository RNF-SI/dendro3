import 'package:dendro3/domain/model/arbre_list.dart';
import 'package:dendro3/domain/model/displayable_list.dart';
import 'package:dendro3/domain/model/saisisable_object.dart';
import 'package:dendro3/domain/model/viewmodel_object.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dendro3/presentation/state/state.dart' as custom_async_state;

final displayableListProvider = StateNotifierProvider.family<
    DisplayableListNotifier,
    DisplayableList,
    DisplayableList>((ref, initialState) {
  return DisplayableListNotifier(initialState);
});

class DisplayableListNotifier extends StateNotifier<DisplayableList> {
  DisplayableListNotifier(DisplayableList initialState) : super(initialState);

  void setDisplayableList(DisplayableList newList) {
    state = newList;
  }

  DisplayableList getDisplayableList() {
    return state;
  }
}
