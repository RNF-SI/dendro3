import 'package:dendro3/domain/model/transect_list.dart';
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
      // ref.watch(createBmSup30AndMesureUseCaseProvider),
      // ref.watch(updateBmSup30UseCaseProvider),
      // ref.watch(deleteBmSup30UseCaseProvider),
      // bmsup30Liste,
      );
});

class TransectListViewModel extends BaseListViewModel<State<TransectList>> {
  // final GetBmSup30ListUseCase _getBmSup30ListUseCase;
  // final CreateBmSup30AndMesureUseCase _createBmSup30AndMesureUseCase;
  // final UpdateBmSup30UseCase _updateBmSup30UseCase;
  // final DeleteBmSup30UseCase _deleteBmSup30UseCase;

  TransectListViewModel(
      // this._getBmSup30ListUseCase,
      // this._createBmSup30AndMesureUseCase,
      // this._updateBmSup30UseCase,
      // this._deleteBmSup30UseCase,
      // final BmSup30List bmsup30Liste
      )
      : super(const State.init()) {}

  void setTransectList(TransectList transectList) {
    state = State.success(transectList);
  }

  TransectList getTransectList() {
    return state.data!;
  }

  @override
  Future<void> addItem(Map item) {
    // TODO: implement addItem
    throw UnimplementedError();
  }
}
