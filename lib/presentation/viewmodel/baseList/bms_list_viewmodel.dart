import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/bmSup30_list.dart';
import 'package:dendro3/domain/usecase/add_bmSup30_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/create_bmSup30_and_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/delete_bmSup30_and_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/delete_bmSup30_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/update_bmSup30_and_mesure_usecase.dart';
import 'package:dendro3/presentation/state/state.dart';
import 'package:dendro3/presentation/viewmodel/baseList/base_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/displayable_list_notifier.dart';
import 'package:dendro3/presentation/viewmodel/last_selected_Id_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bmSup30ListProvider = Provider<BmSup30List>((ref) {
  final state = ref.watch(bmSup30ListViewModelStateNotifierProvider);
  return state.data ?? BmSup30List.empty();
});

final bmSup30ListViewModelStateNotifierProvider =
    StateNotifierProvider<BmSup30ListViewModel, State<BmSup30List>>((ref) {
  final lastSelectedProvider = ref.watch(lastSelectedIdProvider.notifier);
  final displayableListNotifier = ref.watch(displayableListProvider.notifier);

  return BmSup30ListViewModel(
    // ref.watch(getBmSup30ListUseCaseProvider),
    ref.watch(createBmSup30AndMesureUseCaseProvider),
    ref.watch(updateBmSup30AndMesureUseCaseProvider),
    ref.watch(addBmSup30MesureUseCaseProvider),
    ref.watch(deleteBmSup30AndMesureUseCaseProvider),
    ref.watch(deleteBmSup30MesureUseCaseProvider),
    // ref.watch(deleteBmSup30UseCaseProvider),
    // bmsup30Liste,
    lastSelectedProvider,
    displayableListNotifier,
  );
});

class BmSup30ListViewModel extends BaseListViewModel<State<BmSup30List>> {
  late final LastSelectedIdNotifier _lastSelectedProvider;
  late final DisplayableListNotifier _displayableListNotifier;

  // final GetBmSup30ListUseCase _getBmSup30ListUseCase;
  final CreateBmSup30AndMesureUseCase _createBmSup30AndMesureUseCase;
  final UpdateBmSup30AndMesureUseCase _updateBmSup30AndMesureUseCase;
  final AddBmSup30MesureUseCase _addBmSup30MesureUseCase;
  final DeleteBmSup30AndMesureUseCase _deleteBmSup30AndMesureUseCase;
  final DeleteBmSup30MesureUseCase _deleteBmSup30MesureUseCase;

  // final DeleteBmSup30UseCase _deleteBmSup30UseCase;

  BmSup30ListViewModel(
    // this._getBmSup30ListUseCase,
    this._createBmSup30AndMesureUseCase,
    this._updateBmSup30AndMesureUseCase,
    this._addBmSup30MesureUseCase,
    this._deleteBmSup30AndMesureUseCase,
    this._deleteBmSup30MesureUseCase,
    // this._deleteBmSup30UseCase,
    // final BmSup30List bmsup30Liste
    this._lastSelectedProvider,
    this._displayableListNotifier,
  ) : super(const State.init());

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
      _lastSelectedProvider.setLastSelectedId('BmsSup30', newBmSup30.idBmSup30);
      state = State.success(state.data!.addItemToList(newBmSup30));
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
      final newBmSup30 = await _updateBmSup30AndMesureUseCase.execute(
        bmSup30!,
        // idArbreOrig,
        item['idBmSup30'],
        item['idBmSup30Orig'],
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
      // _lastSelectedArbreId = newArbre.idArbreOrig;
      _lastSelectedProvider.setLastSelectedId(
        'BmsSup30',
        newBmSup30.idBmSup30,
      );

      state = State.success(state.data!.updateItemInList(newBmSup30));
      _displayableListNotifier.setDisplayableList(state.data!);
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  addMesureItem(
    BmSup30 bmSup30,
    final Map item,
  ) async {
    try {
      final newBmSup30 = await _addBmSup30MesureUseCase.execute(
        bmSup30,
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
      // _lastSelectedArbreId = newArbre.idArbreOrig;
      _lastSelectedProvider.setLastSelectedId('BmsSup30', newBmSup30.idBmSup30);

      // final aa = state.data!.addArbre(newArbre);
      state = State.success(state.data!.updateItemInList(newBmSup30));
      _displayableListNotifier.setDisplayableList(state.data!);
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  void setBmSup30List(BmSup30List bmsup30List) {
    state = State.success(bmsup30List);
  }

  BmSup30List getBmSup30List() {
    return state.data!;
  }

  @override
  Future<bool> deleteItem(String id) async {
    try {
      await _deleteBmSup30AndMesureUseCase.execute(id);
      _lastSelectedProvider.setLastSelectedId('BmsSup30', null);
      state = State.success(state.data!.removeItemFromList(id));
      _displayableListNotifier.setDisplayableList(state.data!);
      return true;
    } on Exception catch (e) {
      state = State.error(e);
      return false;
    }
  }

  Future<bool> deleteItemMesure(
    String idBmSup30,
    String idBmSup30Mesure,
  ) async {
    try {
      BmSup30? targetedBmSup30;
      for (var bm in state.data!.values) {
        if (bm.idBmSup30 == idBmSup30) {
          targetedBmSup30 = bm;
          break;
        }
      }

      if (targetedBmSup30 == null) {
        throw Exception('BmSup30 not found');
      }

      // Check if the bmsup30 has more than one mesure
      if (targetedBmSup30.bmsSup30Mesures!.length <= 1) {
        throw Exception('BmSup30 has only one mesure');
      }

      BmSup30 bmSup30AfterDeletion = await _deleteBmSup30MesureUseCase.execute(
        targetedBmSup30,
        idBmSup30Mesure,
      );

      List<BmSup30> updatedBmsSup30 = [];
      for (var tempBm in state.data!.values) {
        if (tempBm.idBmSup30 == idBmSup30) {
          updatedBmsSup30.add(bmSup30AfterDeletion);
        } else {
          updatedBmsSup30.add(tempBm);
        }
      }

      // Set the new state with the updated Arbres list
      BmSup30List updatedBmSup30List = BmSup30List(values: updatedBmsSup30);
      state = State.success(updatedBmSup30List);
      _displayableListNotifier.setDisplayableList(updatedBmSup30List);

      _lastSelectedProvider.setLastSelectedId('BmsSup30', null);
      return true;
    } on Exception catch (e) {
      state = State.error(e);
      return false;
    }
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
