import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/regeneration_list.dart';
import 'package:dendro3/domain/usecase/create_regeneration_usecase.dart';
import 'package:dendro3/domain/usecase/update_regeneration_usecase.dart';
import 'package:dendro3/presentation/state/state.dart';
import 'package:dendro3/presentation/viewmodel/baseList/base_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/displayable_list_notifier.dart';
import 'package:dendro3/presentation/viewmodel/last_selected_Id_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final regenerationListProvider = Provider<RegenerationList>((ref) {
  final state = ref.watch(regenerationListViewModelStateNotifierProvider);
  return state.data ?? RegenerationList.empty();
});

final regenerationListViewModelStateNotifierProvider =
    StateNotifierProvider<RegenerationListViewModel, State<RegenerationList>>(
        (ref) {
  final lastSelectedProvider = ref.watch(lastSelectedIdProvider.notifier);
  final displayableListNotifier = ref.watch(displayableListProvider.notifier);

  return RegenerationListViewModel(
    // ref.watch(getBmSup30ListUseCaseProvider),
    ref.watch(createRegenerationUseCaseProvider),
    ref.watch(updateRegenerationUseCaseProvider),

    // ref.watch(updateBmSup30UseCaseProvider),
    // ref.watch(deleteBmSup30UseCaseProvider),
    // bmsup30Liste,
    lastSelectedProvider,
    displayableListNotifier,
  );
});

class RegenerationListViewModel
    extends BaseListViewModel<State<RegenerationList>> {
  late final LastSelectedIdNotifier _lastSelectedProvider;
  late final DisplayableListNotifier _displayableListNotifier;

  // final GetBmSup30ListUseCase _getBmSup30ListUseCase;
  final CreateRegenerationUseCase _createRegenerationUseCase;
  final UpdateRegenerationUseCase _updateRegenerationUseCase;

  // final UpdateBmSup30UseCase _updateBmSup30UseCase;
  // final DeleteBmSup30UseCase _deleteBmSup30UseCase;

  RegenerationListViewModel(
    // this._getBmSup30ListUseCase,
    this._createRegenerationUseCase,
    this._updateRegenerationUseCase,

    // this._updateBmSup30UseCase,
    // this._deleteBmSup30UseCase,
    // final BmSup30List bmsup30Liste
    this._lastSelectedProvider,
    this._displayableListNotifier,
  ) : super(const State.init()) {}

  void setRegenerationList(RegenerationList regenerationList) {
    state = State.success(regenerationList);
  }

  RegenerationList getRegenerationList() {
    return state.data!;
  }

  @override
  Future<void> addItem(Map item) async {
    try {
      final newRege = await _createRegenerationUseCase.execute(
        item["idCyclePlacette"],
        item["sousPlacette"],
        item["codeEssence"],
        item["recouvrement"],
        item["classe1"],
        item["classe2"],
        item["classe3"],
        item["taillis"],
        item["abroutissement"],
        item["idNomenclatureAbroutissement"],
        item["observation"],
      );

      _lastSelectedProvider.setLastSelectedId(
          'Regenerations', newRege.idRegeneration);
      state = State.success(state.data!.addItemToList(newRege));
      _displayableListNotifier.setDisplayableList(state.data!);
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
      final updatedRege = await _updateRegenerationUseCase.execute(
        item["idRegeneration"],
        item["idCyclePlacette"],
        item["sousPlacette"],
        item["codeEssence"],
        item["recouvrement"],
        item["classe1"],
        item["classe2"],
        item["classe3"],
        item["taillis"],
        item["abroutissement"],
        item["idNomenclatureAbroutissement"],
        item["observation"],
      );
      _lastSelectedProvider.setLastSelectedId(
          'Regenerations', updatedRege.idRegeneration);
      state = State.success(state.data!.updateItemInList(updatedRege));
      _displayableListNotifier.setDisplayableList(state.data!);

      // state = State.success(state.data!.updateItemToList(newBmSup30));
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  @override
  Future<void> deleteItem(String id) {
    // TODO: implement deleteItem
    throw UnimplementedError();
  }
}
