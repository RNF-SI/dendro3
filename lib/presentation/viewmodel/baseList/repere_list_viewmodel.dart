import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/repere_list.dart';
import 'package:dendro3/domain/usecase/create_repere_usecase.dart';
import 'package:dendro3/domain/usecase/update_repere_usecase.dart';
import 'package:dendro3/domain/usecase/update_transect_usecase.dart';
import 'package:dendro3/presentation/state/state.dart';
import 'package:dendro3/presentation/viewmodel/baseList/base_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/displayable_list_notifier.dart';
import 'package:dendro3/presentation/viewmodel/last_selected_Id_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final repereListProvider = Provider<RepereList>((ref) {
  final state = ref.watch(repereListViewModelStateNotifierProvider);
  return state.data ?? RepereList.empty();
});

final repereListViewModelStateNotifierProvider =
    StateNotifierProvider<RepereListViewModel, State<RepereList>>((ref) {
  final lastSelectedProvider = ref.watch(lastSelectedIdProvider.notifier);
  final displayableListNotifier = ref.watch(displayableListProvider.notifier);

  return RepereListViewModel(
    // ref.watch(getBmSup30ListUseCaseProvider),
    ref.watch(createRepereUseCaseProvider),
    ref.watch(updateRepereUseCaseProvider),

    // ref.watch(updateBmSup30UseCaseProvider),
    // ref.watch(deleteBmSup30UseCaseProvider),
    // bmsup30Liste,
    lastSelectedProvider,
    displayableListNotifier,
  );
});

class RepereListViewModel extends BaseListViewModel<State<RepereList>> {
  late final LastSelectedIdNotifier _lastSelectedProvider;
  late final DisplayableListNotifier _displayableListNotifier;

  // final GetBmSup30ListUseCase _getBmSup30ListUseCase;
  final CreateRepereUseCase _createRepereUseCase;
  final UpdateRepereUseCase _updateRepereUseCase;

  // final UpdateBmSup30UseCase _updateBmSup30UseCase;
  // final DeleteBmSup30UseCase _deleteBmSup30UseCase;

  RepereListViewModel(
    // this._getBmSup30ListUseCase,
    this._createRepereUseCase,
    this._updateRepereUseCase,
    // this._deleteBmSup30UseCase,
    // final BmSup30List bmsup30Liste
    this._lastSelectedProvider,
    this._displayableListNotifier,
  ) : super(const State.init()) {}

  void setRepereList(RepereList repereList) {
    state = State.success(repereList);
  }

  RepereList getRepereList() {
    return state.data!;
  }

  @override
  Future<void> addItem(Map item) async {
    try {
      final newRepere = await _createRepereUseCase.execute(
          item["idPlacette"],
          item["azimut"],
          item["distance"],
          item["diametre"],
          item["repere"],
          item["observation"]);

      _lastSelectedProvider.setLastSelectedId('Reperes', newRepere.idRepere);
      state = State.success(state.data!.addItemToList(newRepere));
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
      final updatedRepere = await _updateRepereUseCase.execute(
          item["idRepere"],
          item["idPlacette"],
          item["azimut"],
          item["distance"],
          item["diametre"],
          item["repere"],
          item["observation"]);

      _lastSelectedProvider.setLastSelectedId(
          'Reperes', updatedRepere.idRepere);
      state = State.success(state.data!.updateItemInList(updatedRepere));
      _displayableListNotifier.setDisplayableList(state.data!);
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
