import 'package:dendro3/domain/model/displayable_list.dart';
import 'package:dendro3/domain/model/viewmodel_object.dart';
import 'package:dendro3/presentation/viewmodel/baseList/arbre_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/baseList/bms_list_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final displayableListProvider =
    StateNotifierProvider<DisplayableListNotifier, DisplayableList>((ref) {
  return DisplayableListNotifier(ref);
});

class DisplayableListNotifier extends StateNotifier<DisplayableList> {
  DisplayableListNotifier(Ref ref) : super(ref.watch(arbreListProvider));

  void setDisplayableList(WidgetRef ref, String type) {
    switch (type) {
      case 'Arbres':
        state = ref.watch(arbreListProvider);

        break;
      case 'BmsSup30':
        state = ref.watch(bmSup30ListProvider);

        break;
      default:
    }
  }

  DisplayableList getDisplayableList() {
    return state;
  }
}
