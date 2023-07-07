import 'package:dendro3/domain/model/regeneration_list.dart';
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
      // ref.watch(createBmSup30AndMesureUseCaseProvider),
      // ref.watch(updateBmSup30UseCaseProvider),
      // ref.watch(deleteBmSup30UseCaseProvider),
      // bmsup30Liste,
      );
});

class RegenerationListViewModel
    extends BaseListViewModel<State<RegenerationList>> {
  // final GetBmSup30ListUseCase _getBmSup30ListUseCase;
  // final CreateBmSup30AndMesureUseCase _createBmSup30AndMesureUseCase;
  // final UpdateBmSup30UseCase _updateBmSup30UseCase;
  // final DeleteBmSup30UseCase _deleteBmSup30UseCase;

  RegenerationListViewModel(
      // this._getBmSup30ListUseCase,
      // this._createBmSup30AndMesureUseCase,
      // this._updateBmSup30UseCase,
      // this._deleteBmSup30UseCase,
      // final BmSup30List bmsup30Liste
      )
      : super(const State.init()) {}

  void setRegenerationList(RegenerationList regenerationList) {
    state = State.success(regenerationList);
  }

  RegenerationList getRegenerationList() {
    return state.data!;
  }

  @override
  Future<void> addItem(Map item) {
    // TODO: implement addItem
    throw UnimplementedError();
  }
}
