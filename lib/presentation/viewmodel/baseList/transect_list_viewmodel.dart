import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/transect_list.dart';
import 'package:dendro3/domain/usecase/create_transect_usecase.dart';
import 'package:dendro3/presentation/state/state.dart';
import 'package:dendro3/presentation/viewmodel/baseList/base_list_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final transectListProvider = Provider<TransectList>((ref) {
  final state = ref.watch(transectListViewModelStateNotifierProvider);
  return state.data ?? TransectList.empty();
});

final transectListViewModelStateNotifierProvider =
    StateNotifierProvider<TransectListViewModel, State<TransectList>>((ref) {
  return TransectListViewModel(
    // ref.watch(getBmSup30ListUseCaseProvider),
    ref.watch(createTransectUseCaseProvider),
    // ref.watch(updateBmSup30UseCaseProvider),
    // ref.watch(deleteBmSup30UseCaseProvider),
    // bmsup30Liste,
  );
});

class TransectListViewModel extends BaseListViewModel<State<TransectList>> {
  // final GetBmSup30ListUseCase _getBmSup30ListUseCase;
  final CreateTransectUseCase _createTransectUseCase;
  // final UpdateBmSup30UseCase _updateBmSup30UseCase;
  // final DeleteBmSup30UseCase _deleteBmSup30UseCase;

  TransectListViewModel(
    // this._getBmSup30ListUseCase,
    this._createTransectUseCase,
    // this._updateBmSup30UseCase,
    // this._deleteBmSup30UseCase,
    // final BmSup30List bmsup30Liste
  ) : super(const State.init()) {}

  void setTransectList(TransectList transectList) {
    state = State.success(transectList);
  }

  TransectList getTransectList() {
    return state.data!;
  }

  @override
  Future<void> addItem(Map item) async {
    try {
      final newRege = await _createTransectUseCase.execute(
        item["idCyclePlacette"],
        item["codeEssence"],
        item["refTransect"],
        item["distance"],
        item["orientation"],
        item["azimutSouche"],
        item["distanceSouche"],
        item["diametre"],
        item["diametre130"],
        item["ratioHauteur"],
        item["contact"],
        item["angle"],
        item["chablis"],
        item["stadeDurete"],
        item["stadeEcorce"],
        item["observation"],
      );
      state = State.success(state.data!.addItemToList(newRege));
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  @override
  updateItem(
    final Map item,
    // final int idArbreOrig,
  ) async {}
}
