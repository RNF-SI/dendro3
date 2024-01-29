import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:dendro3/domain/model/corCyclePlacette_list.dart';
import 'package:dendro3/domain/usecase/complete_cycle_placette_created_usecase.dart';
import 'package:dendro3/domain/usecase/create_cor_cycle_placette_usecase.dart';
import 'package:dendro3/domain/usecase/set_cycle_placette_created_usecase.dart';
import 'package:dendro3/presentation/state/state.dart';
import 'package:dendro3/presentation/viewmodel/baseList/base_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/cor_cycle_placette_local_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final corCyclePlacetteListProvider = Provider<CorCyclePlacetteList>((ref) {
  final state = ref.watch(corCyclePlacetteListViewModelStateNotifierProvider);
  return state.data ?? CorCyclePlacetteList.empty();
});

final corCyclePlacetteListViewModelStateNotifierProvider =
    StateNotifierProvider<CorCyclePlacetteListViewModel,
        State<CorCyclePlacetteList>>((ref) {
  return CorCyclePlacetteListViewModel(
    ref.watch(createCorCyclePlacetteUseCaseProvider),
    ref.watch(setCyclePlacetteCreatedUseCaseProvider),
    ref.watch(completeCyclePlacetteCreatedUseCaseProvider),
    ref.watch(corCyclePlacetteLocalStorageStatusStateNotifierProvider.notifier),
  );
});

class CorCyclePlacetteListViewModel
    extends BaseListViewModel<State<CorCyclePlacetteList>> {
  final CreateCorCyclePlacetteUseCase _createCorCyclePlacetteUseCase;
  final SetCyclePlacetteCreatedUseCase _setCyclePlacetteCreatedUseCaseProvider;
  final CompleteCyclePlacetteCreatedUseCase
      _completeCyclePlacetteCreatedUseCaseProvider;
  final CorCyclePlacetteLocalStorageStatusNotifier _localStorageStatusNotifier;

  CorCyclePlacetteListViewModel(
    this._createCorCyclePlacetteUseCase,
    this._setCyclePlacetteCreatedUseCaseProvider,
    this._completeCyclePlacetteCreatedUseCaseProvider,
    this._localStorageStatusNotifier,
  ) : super(const State.init()) {}

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
      );
      await _localStorageStatusNotifier.startCyclePlacette(newCorCyclePlacette
          .idCyclePlacette); // Mark the cycle as created using SetCycleCreatedUseCase
      state = State.success(state.data!.addItemToList(newCorCyclePlacette));
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  @override
  updateItem(
    final Map item, {
    Arbre? arbre,
    BmSup30? bmSup30,
  }
      // final int idArbreOrig,
      ) async {}

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
  Future<void> deleteItem(String id) {
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
