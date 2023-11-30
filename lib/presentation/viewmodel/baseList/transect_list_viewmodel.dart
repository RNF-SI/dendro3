import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/transect_list.dart';
import 'package:dendro3/domain/usecase/create_transect_usecase.dart';
import 'package:dendro3/domain/usecase/update_transect_usecase.dart';
import 'package:dendro3/presentation/state/state.dart';
import 'package:dendro3/presentation/viewmodel/baseList/base_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/displayable_list_notifier.dart';
import 'package:dendro3/presentation/viewmodel/last_modified_Id_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final transectListProvider = Provider<TransectList>((ref) {
  final state = ref.watch(transectListViewModelStateNotifierProvider);
  return state.data ?? TransectList.empty();
});

final transectListViewModelStateNotifierProvider =
    StateNotifierProvider<TransectListViewModel, State<TransectList>>((ref) {
  final lastModifiedProvider = ref.watch(lastModifiedIdProvider.notifier);
  final displayableListNotifier = ref.watch(displayableListProvider.notifier);

  return TransectListViewModel(
    // ref.watch(getBmSup30ListUseCaseProvider),
    ref.watch(createTransectUseCaseProvider),
    ref.watch(updateTransectUseCaseProvider),
    // ref.watch(updateBmSup30UseCaseProvider),
    // ref.watch(deleteBmSup30UseCaseProvider),
    // bmsup30Liste,
    lastModifiedProvider,
    displayableListNotifier,
  );
});

class TransectListViewModel extends BaseListViewModel<State<TransectList>> {
  late final LastModifiedIdNotifier _lastModifiedProvider;
  late final DisplayableListNotifier _displayableListNotifier;

  // final GetBmSup30ListUseCase _getBmSup30ListUseCase;
  final CreateTransectUseCase _createTransectUseCase;
  final UpdateTransectUseCase _updateTransectUseCase;
  // final DeleteBmSup30UseCase _deleteBmSup30UseCase;

  TransectListViewModel(
    // this._getBmSup30ListUseCase,
    this._createTransectUseCase,
    this._updateTransectUseCase,
    // this._deleteBmSup30UseCase,
    // final BmSup30List bmsup30Liste,
    this._lastModifiedProvider,
    this._displayableListNotifier,
  ) : super(const State.init()) {}

  void setTransectList(TransectList transectList) {
    state = State.success(transectList);
  }

  TransectList getTransectList() {
    return state.data!;
  }

  @override
  Future<void> addItem(
    Map item,
  ) async {
    try {
      final newTransect = await _createTransectUseCase.execute(
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
      _lastModifiedProvider.setLastModifiedId(
          'Transects', newTransect.idTransect);
      state = State.success(state.data!.addItemToList(newTransect));
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
      final updatedTransect = await _updateTransectUseCase.execute(
        item["idTransect"],
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

      _lastModifiedProvider.setLastModifiedId(
          'Transects', updatedTransect.idTransect);
      state = State.success(state.data!.updateItemInList(updatedTransect));
      _displayableListNotifier.setDisplayableList(state.data!);
    } on Exception catch (e) {
      state = State.error(e);
    }
  }
}
