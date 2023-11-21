import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/repere_list.dart';
import 'package:dendro3/domain/usecase/create_repere_usecase.dart';
import 'package:dendro3/presentation/state/state.dart';
import 'package:dendro3/presentation/viewmodel/baseList/base_list_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final repereListProvider = Provider<RepereList>((ref) {
  final state = ref.watch(repereListViewModelStateNotifierProvider);
  return state.data ?? RepereList.empty();
});

final repereListViewModelStateNotifierProvider =
    StateNotifierProvider<RepereListViewModel, State<RepereList>>((ref) {
  return RepereListViewModel(
    // ref.watch(getBmSup30ListUseCaseProvider),
    ref.watch(createRepereUseCaseProvider),
    // ref.watch(updateBmSup30UseCaseProvider),
    // ref.watch(deleteBmSup30UseCaseProvider),
    // bmsup30Liste,
  );
});

class RepereListViewModel extends BaseListViewModel<State<RepereList>> {
  // final GetBmSup30ListUseCase _getBmSup30ListUseCase;
  final CreateRepereUseCase _createRepereUseCase;
  // final UpdateBmSup30UseCase _updateBmSup30UseCase;
  // final DeleteBmSup30UseCase _deleteBmSup30UseCase;

  RepereListViewModel(
    // this._getBmSup30ListUseCase,
    this._createRepereUseCase,
    // this._updateBmSup30UseCase,
    // this._deleteBmSup30UseCase,
    // final BmSup30List bmsup30Liste
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
      state = State.success(state.data!.addItemToList(newRepere));
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
