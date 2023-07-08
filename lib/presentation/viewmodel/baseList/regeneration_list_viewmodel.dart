import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/regeneration_list.dart';
import 'package:dendro3/domain/usecase/create_regeneration_usecase.dart';
import 'package:dendro3/presentation/state/state.dart';
import 'package:dendro3/presentation/viewmodel/baseList/base_list_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final regenerationListProvider = Provider<RegenerationList>((ref) {
  final state = ref.watch(regenerationListViewModelStateNotifierProvider);
  return state.data ?? RegenerationList.empty();
});

final regenerationListViewModelStateNotifierProvider =
    StateNotifierProvider<RegenerationListViewModel, State<RegenerationList>>(
        (ref) {
  return RegenerationListViewModel(
    // ref.watch(getBmSup30ListUseCaseProvider),
    ref.watch(createRegenerationUseCaseProvider),
    // ref.watch(updateBmSup30UseCaseProvider),
    // ref.watch(deleteBmSup30UseCaseProvider),
    // bmsup30Liste,
  );
});

class RegenerationListViewModel
    extends BaseListViewModel<State<RegenerationList>> {
  // final GetBmSup30ListUseCase _getBmSup30ListUseCase;
  final CreateRegenerationUseCase _createRegenerationUseCase;
  // final UpdateBmSup30UseCase _updateBmSup30UseCase;
  // final DeleteBmSup30UseCase _deleteBmSup30UseCase;

  RegenerationListViewModel(
    // this._getBmSup30ListUseCase,
    this._createRegenerationUseCase,
    // this._updateBmSup30UseCase,
    // this._deleteBmSup30UseCase,
    // final BmSup30List bmsup30Liste
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
      state = State.success(state.data!.addItemToList(newRege));
    } on Exception catch (e) {
      state = State.error(e);
    }
  }
}
