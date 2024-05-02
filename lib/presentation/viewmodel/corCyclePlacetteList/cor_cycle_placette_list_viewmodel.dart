import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/corCyclePlacette_list.dart';
import 'package:dendro3/domain/usecase/complete_cycle_placette_created_usecase.dart';
import 'package:dendro3/domain/usecase/create_cor_cycle_placette_usecase.dart';
import 'package:dendro3/domain/usecase/set_cycle_placette_created_usecase.dart';
import 'package:dendro3/domain/usecase/update_cor_cycle_placette_usecase.dart';
import 'package:dendro3/presentation/state/state.dart';
import 'package:dendro3/presentation/viewmodel/baseList/base_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/baseList/placette_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/cor_cycle_placette_local_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final corCyclePlacetteListProvider = Provider<CorCyclePlacetteList>((ref) {
  final state = ref.watch(corCyclePlacetteListViewModelStateNotifierProvider);
  return state.data ?? CorCyclePlacetteList.empty();
});

final corCyclePlacetteListViewModelStateNotifierProvider =
    StateNotifierProvider<CorCyclePlacetteListViewModel,
        State<CorCyclePlacetteList>>((ref) {
  final placetteViewModel =
      ref.watch(placetteViewModelStateNotifierProvider.notifier);
  return CorCyclePlacetteListViewModel(
    ref.watch(createCorCyclePlacetteUseCaseProvider),
    ref.watch(updateCorCyclePlacetteUseCaseProvider),
    ref.watch(setCyclePlacetteCreatedUseCaseProvider),
    ref.watch(completeCyclePlacetteCreatedUseCaseProvider),
    ref.watch(corCyclePlacetteLocalStorageStatusStateNotifierProvider.notifier),
    placetteViewModel,
  );
});

class CorCyclePlacetteListViewModel
    extends BaseListViewModel<State<CorCyclePlacetteList>> {
  final CreateCorCyclePlacetteUseCase _createCorCyclePlacetteUseCase;
  final UpdateCorCyclePlacetteUseCase _updateCorCyclePlacetteUseCase;
  final SetCyclePlacetteCreatedUseCase _setCyclePlacetteCreatedUseCaseProvider;
  final CompleteCyclePlacetteCreatedUseCase
      _completeCyclePlacetteCreatedUseCaseProvider;
  final CorCyclePlacetteLocalStorageStatusNotifier _localStorageStatusNotifier;
  late final PlacetteViewModel _placetteViewModel;

  CorCyclePlacetteListViewModel(
    this._createCorCyclePlacetteUseCase,
    this._updateCorCyclePlacetteUseCase,
    this._setCyclePlacetteCreatedUseCaseProvider,
    this._completeCyclePlacetteCreatedUseCaseProvider,
    this._localStorageStatusNotifier,
    this._placetteViewModel,
  ) : super(const State.init());

  actualiser() {
    state = State.success(state.data!);
  }

  @override
  addItem(
    final Map item,
  ) async {
    try {
      final newCorCyclePlacette = await _createCorCyclePlacetteUseCase.execute(
        item['idCycle'],
        item['idPlacette'],
        item['dateReleve'],
        item['dateIntervention'],
        item['annee'],
        item['natureIntervention'],
        item['gestionPlacette'],
        item['idNomenclatureCastor'],
        item['idNomenclatureFrottis'],
        item['idNomenclatureBoutis'],
        item['recouvHerbesBasses'],
        item['recouvHerbesHautes'],
        item['recouvBuissons'],
        item['recouvArbres'],
        item['coeff'],
        item['diamLim'],
      );
      await _localStorageStatusNotifier.startCyclePlacette(newCorCyclePlacette
          .idCyclePlacette); // Mark the cycle as created using SetCycleCreatedUseCase
      state = State.success(state.data!.addItemToList(newCorCyclePlacette));
      _placetteViewModel.appendToCorCyclePlacetteList(newCorCyclePlacette);
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  @override
  updateItem(
    final Map item, {
    Arbre? arbre,
    BmSup30? bmSup30,
  }) async {
    try {
      final updatedCorCyclePlacette =
          await _updateCorCyclePlacetteUseCase.execute(
        item['idCyclePlacette'],
        item['idCycle'],
        item['idPlacette'],
        item['dateReleve'],
        item['dateIntervention'],
        item['annee'],
        item['natureIntervention'],
        item['gestionPlacette'],
        item['idNomenclatureCastor'],
        item['idNomenclatureFrottis'],
        item['idNomenclatureBoutis'],
        item['recouvHerbesBasses'],
        item['recouvHerbesHautes'],
        item['recouvBuissons'],
        item['recouvArbres'],
        item['coeff'],
        item['diamLim'],
      );
      state =
          State.success(state.data!.updateItemInList(updatedCorCyclePlacette));
      _placetteViewModel.updateCorCyclePlacetteList(updatedCorCyclePlacette);
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  // Create a new corCyclePlacette
  startCycleForPlacette() {
    // try {
    //   final newCorCyclePlacette = await _createCorCyclePlacetteUseCase.execute(
    //     // idArbreOrig,
    //     // idPlacette,
    //     // codeEssence,
    //     // azimut,
    //   );
    // }
  }

  void setCorCyclePlacetteList(CorCyclePlacetteList corCyclePlacetteList) {
    state = State.success(corCyclePlacetteList);
  }

  @override
  Future<bool> deleteItem(String id) {
    // TODO: implement deleteItem
    throw UnimplementedError();
  }

  getCorCyclePlacetteFromIdCycle(int idCycle) {
    return state.data!.getCorCyclePlacetteByIdCycle(idCycle);
  }

  refreshList() {
    state = State.success(state.data!);
  }
}
