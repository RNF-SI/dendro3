import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/model/placette_list.dart';
import 'package:dendro3/presentation/state/state.dart';
import 'package:dendro3/presentation/viewmodel/baseList/base_list_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final placetteListProvider = Provider<PlacetteList?>((ref) {
  final state = ref.watch(placetteListViewModelStateNotifierProvider);
  return state.data;
});

final placetteListViewModelStateNotifierProvider =
    StateNotifierProvider<PlacetteListViewModel, State<PlacetteList>>((ref) {
  return PlacetteListViewModel();
});

// TODO: Revoir ce viewmodel quand il sera utilisé

class PlacetteListViewModel extends BaseListViewModel<State<PlacetteList>> {
  PlacetteListViewModel() : super(const State.init());

  void setPlacetteList(PlacetteList placetteList) {
    state = State.success(placetteList);
  }

  PlacetteList getPlacetteList() {
    return state.data!;
  }

  @override
  Future<bool> deleteItem(String id) {
    // TODO: implement deleteItem
    // Pour l'instant n'est pas à implémenter, si c'est le cas, alors changer String par int
    throw UnimplementedError();
  }

  @override
  Future<void> addItem(Map item) {
    // TODO: implement addItem
    throw UnimplementedError();
  }

  @override
  Future<void> updateItem(
    Map item, {
    Arbre? arbre,
    BmSup30? bmSup30,
  }) async {
    state = State.success(state.data!.updateItemInList(item));
  }

  Future<void> updateList(Placette item) async {
    state = State.success(
        state.data!.updateItemExpositionPenteAndCorCyclePlacetteInList(item));
  }
}
