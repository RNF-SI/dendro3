import 'package:dendro3/domain/model/displayable_list.dart';
import 'package:dendro3/domain/model/viewmodel_object.dart';
import 'package:dendro3/presentation/viewmodel/baseList/arbre_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/baseList/bms_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/baseList/regeneration_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/baseList/repere_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/baseList/transect_list_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final displayTypeProvider = StateProvider<String>((ref) => 'Arbres');

final displayableListProvider =
    StateNotifierProvider<DisplayableListNotifier, DisplayableList>((ref) {
  return DisplayableListNotifier(ref);
});

class DisplayableListNotifier extends StateNotifier<DisplayableList> {
  DisplayableListNotifier(Ref ref)
      : super(
          ref.read(arbreListProvider),
        );

  void setDisplayableListFromListProvider(WidgetRef ref, String type) {
    switch (type) {
      case 'Arbres':
        state = ref.read(arbreListProvider);
        break;
      case 'BmsSup30':
        state = ref.read(bmSup30ListProvider);
        break;
      case 'Transects':
        state = ref.read(transectListProvider);
        break;
      case 'Regenerations':
        state = ref.read(regenerationListProvider);
        break;
      case 'Reperes':
        state = ref.read(repereListProvider);
        break;
      default:
    }
  }

  void setDisplayableList(DisplayableList displayableList) {
    state = displayableList;
  }

  DisplayableList getDisplayableList() {
    return state;
  }
}
