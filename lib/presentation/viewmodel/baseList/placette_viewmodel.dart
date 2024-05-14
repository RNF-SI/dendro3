import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:dendro3/domain/model/corCyclePlacette_list.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/model/placette_list.dart';
import 'package:dendro3/domain/usecase/get_placette_usecase.dart';
import 'package:dendro3/domain/usecase/update_placette_usecase.dart';
import 'package:dendro3/presentation/state/state.dart';
import 'package:dendro3/presentation/viewmodel/baseList/base_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/baseList/placette_list_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final placetteProvider = Provider<Placette?>((ref) {
  final state = ref.watch(placetteViewModelStateNotifierProvider);
  return state.data;
});

final placetteViewModelStateNotifierProvider =
    StateNotifierProvider<PlacetteViewModel, State<Placette>>((ref) {
  final placetteListViewModel =
      ref.watch(placetteListViewModelStateNotifierProvider.notifier);
  return PlacetteViewModel(
    ref.watch(getPlacetteUseCaseProvider),
    ref.watch(updatePlacetteUseCaseProvider),
    placetteListViewModel,
  );
});

// TODO: Revoir ce viewmodel quand il sera utilisé

class PlacetteViewModel extends BaseListViewModel<State<Placette>> {
  final GetPlacetteUseCase _getPlacetteUseCase;
  final UpdatePlacetteUseCase _updatePlacetteUseCase;
  late final PlacetteListViewModel _placetteListViewModel;

  PlacetteViewModel(
    this._getPlacetteUseCase,
    this._updatePlacetteUseCase,
    this._placetteListViewModel,
  ) : super(const State.init());

  void setPlacette(Placette placette) {
    state = State.success(placette);
  }

  Placette getPlacette() {
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
    final Placette newPlacette = await _updatePlacetteUseCase.execute(
      item["idPlacette"],
      item["pente"],
      item["exposition"],
    );

    _placetteListViewModel.updateList(newPlacette);

    state = State.success(newPlacette);
    // final value = state.data!.updatePlacette(newPlacette);
  }

  Future<void> appendToCorCyclePlacetteList(
      CorCyclePlacette corCyclePlacette) async {
    final Placette oldPlacette = state.data!;
    final Placette newPlacette = oldPlacette.updateCorCyclesPlacettes(
        oldPlacette.corCyclesPlacettes?.addItemToList(corCyclePlacette));
    _placetteListViewModel.updateList(newPlacette);
    state = State.success(newPlacette);
  }

  Future<void> updateCorCyclePlacetteList(
      CorCyclePlacette updatedCorCyclePlacette) async {
    final Placette oldPlacette = state.data!;
    final newCorCyclesPlacettes = oldPlacette.corCyclesPlacettes
        ?.updateCorCyclePlacette(updatedCorCyclePlacette);

    final Placette newPlacette =
        oldPlacette.copyWith(corCyclesPlacettes: newCorCyclesPlacettes);
    _placetteListViewModel.updateList(newPlacette);
    state = State.success(newPlacette);
  }
}
