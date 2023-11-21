import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/bmSup30_list.dart';
import 'package:dendro3/domain/usecase/create_bmSup30_and_mesure_usecase.dart';
import 'package:dendro3/presentation/state/state.dart';
import 'package:dendro3/presentation/viewmodel/baseList/base_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/placette/saisie_placette_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bmSup30ListProvider = Provider<BmSup30List>((ref) {
  final state = ref.watch(bmSup30ListViewModelStateNotifierProvider);
  return state.data ?? BmSup30List.empty();
});

final bmSup30ListViewModelStateNotifierProvider =
    StateNotifierProvider<BmSup30ListViewModel, State<BmSup30List>>((ref) {
  return BmSup30ListViewModel(
    // ref.watch(getBmSup30ListUseCaseProvider),
    ref.watch(createBmSup30AndMesureUseCaseProvider),
    // ref.watch(updateBmSup30UseCaseProvider),
    // ref.watch(deleteBmSup30UseCaseProvider),
    // bmsup30Liste,
  );
});

class BmSup30ListViewModel extends BaseListViewModel<State<BmSup30List>> {
  // final GetBmSup30ListUseCase _getBmSup30ListUseCase;
  final CreateBmSup30AndMesureUseCase _createBmSup30AndMesureUseCase;
  // final UpdateBmSup30UseCase _updateBmSup30UseCase;
  // final DeleteBmSup30UseCase _deleteBmSup30UseCase;

  BmSup30ListViewModel(
    // this._getBmSup30ListUseCase,
    this._createBmSup30AndMesureUseCase,
    // this._updateBmSup30UseCase,
    // this._deleteBmSup30UseCase,
    // final BmSup30List bmsup30Liste
  ) : super(const State.init()) {}

  // completeBmSup30(final BmSup30 todo) {
  //   final newBmSup30 = todo.copyWith(isCompleted: true);
  //   updateBmSup30(newBmSup30);
  // }

  // undoBmSup30(final BmSup30 todo) {
  //   final newBmSup30 = todo.copyWith(isCompleted: false);
  //   updateBmSup30(newBmSup30);
  // }

  // _getBmSup30List() async {
  //   try {
  //     state = const State.loading();
  //     final todoList = await _getBmSup30ListUseCase.execute();
  //     state = State.success(todoList);
  //   } on Exception catch (e) {
  //     state = State.error(e);
  //   }
  // }

  @override
  addItem(
    final Map item,
  ) async {
    try {
      final newBmSup30 = await _createBmSup30AndMesureUseCase.execute(
        item["idPlacette"],
        item["idArbre"],
        item["codeEssence"],
        item["azimut"],
        item["distance"],
        item["orientation"],
        item["azimutSouche"],
        item["distanceSouche"],
        item["observation"],
        item["idBmSup30Mesure"],
        item["idBmSup30"],
        item["idCycle"],
        item["diametreIni"],
        item["diametreMed"],
        item["diametreFin"],
        item["diametre130"],
        item["longueur"],
        item["ratioHauteur"],
        item["contact"],
        item["chablis"],
        item["stadeDurete"],
        item["stadeEcorce"],
        item["observationMesure"],
      );
      // final aa = state.data!.addBmSup30(newBmSup30);
      state = State.success(state.data!.addItemToList(newBmSup30));
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  @override
  updateItem(
    final Map item,
    // final int idArbreOrig,
  ) async {}

  void setBmSup30List(BmSup30List bmsup30List) {
    state = State.success(bmsup30List);
  }

  BmSup30List getBmSup30List() {
    return state.data!;
  }

  // updateBmSup30(final BmSup30 newBmSup30) async {
  //   try {
  //     await _updateBmSup30UseCase.execute(
  //       newBmSup30.id,
  //       newBmSup30.title,
  //       newBmSup30.description,
  //       newBmSup30.isCompleted,
  //       newBmSup30.dueDate,
  //     );
  //     state = State.success(state.data!.updateBmSup30(newBmSup30));
  //   } on Exception catch (e) {
  //     state = State.error(e);
  //   }
  // }

  // deleteBmSup30(final BmSup30Id id) async {
  //   try {
  //     await _deleteBmSup30UseCase.execute(id);
  //     state = State.success(state.data!.removeBmSup30ById(id));
  //   } on Exception catch (e) {
  //     state = State.error(e);
  //   }
  // }
}
