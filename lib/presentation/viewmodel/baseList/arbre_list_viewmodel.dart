import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/arbreMesure_list.dart';
import 'package:dendro3/domain/model/arbre_list.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/saisisable_object.dart';
import 'package:dendro3/domain/usecase/add_arbre_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/create_arbre_and_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/delete_arbre_and_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/delete_arbre_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/update_arbre_and_mesure_usecase.dart';
import 'package:dendro3/presentation/state/state.dart';
import 'package:dendro3/presentation/viewmodel/baseList/base_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/displayable_list_notifier.dart';
import 'package:dendro3/presentation/viewmodel/last_modified_Id_notifier.dart';
import 'package:dendro3/presentation/viewmodel/placette/saisie_placette_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final lastModifiedArbreIdProvider = Provider<int?>((ref) {
  final viewModel = ref.watch(arbreListViewModelStateNotifierProvider.notifier);
  return viewModel.getLastModifiedArbreId();
});

final arbreListProvider = Provider<ArbreList>((ref) {
  final state = ref.watch(arbreListViewModelStateNotifierProvider);
  return state.data ?? ArbreList.empty();
});

final arbreListViewModelStateNotifierProvider =
    StateNotifierProvider<ArbreListViewModel, State<ArbreList>>((ref) {
  final lastModifiedProvider = ref.watch(lastSelectedIdProvider.notifier);
  final displayableListNotifier = ref.watch(displayableListProvider.notifier);

  return ArbreListViewModel(
    // ref.watch(getArbreListUseCaseProvider),
    ref.watch(createArbreAndMesureUseCaseProvider),
    ref.watch(updateArbreAndMesureUseCaseProvider),
    ref.watch(addArbreMesureUseCaseProvider),
    ref.watch(deleteArbreAndMesureUseCaseProvider),
    ref.watch(deleteArbreMesureUseCaseProvider),
    // ref.watch(deleteArbreUseCaseProvider),
    // arbreListe,
    lastModifiedProvider,
    displayableListNotifier,
  );
});

class ArbreListViewModel extends BaseListViewModel<State<ArbreList>> {
  late final LastSelectedIdNotifier _lastModifiedProvider;
  late final DisplayableListNotifier _displayableListNotifier;

  // final Ref ref;
  // final GetArbreListUseCase _getArbreListUseCase;
  final CreateArbreAndMesureUseCase _createArbreAndMesureUseCase;
  final UpdateArbreAndMesureUseCase _updateArbreAndMesureUseCase;
  final AddArbreMesureUseCase _addArbreMesureUseCase;
  final DeleteArbreAndMesureUseCase _deleteArbreAndMesureUseCase;
  final DeleteArbreMesureUseCase _deleteArbreMesureUseCase;
  // final DeleteArbreUseCase _deleteArbreUseCase;

  int? _lastModifiedArbreId;

  ArbreListViewModel(
    // this._getArbreListUseCase,
    this._createArbreAndMesureUseCase,
    this._updateArbreAndMesureUseCase,
    this._addArbreMesureUseCase,
    this._deleteArbreAndMesureUseCase,
    this._deleteArbreMesureUseCase,
    // this._deleteArbreUseCase,
    // final ArbreList arbreListe
    this._lastModifiedProvider,
    this._displayableListNotifier,
  ) : super(const State.init()) {}

  // completeArbre(final Arbre todo) {
  //   final newArbre = todo.copyWith(isCompleted: true);
  //   updateArbre(newArbre);
  // }

  // undoArbre(final Arbre todo) {
  //   final newArbre = todo.copyWith(isCompleted: false);
  //   updateArbre(newArbre);
  // }

  // _getArbreList() async {
  //   try {
  //     state = const State.loading();
  //     final todoList = await _getArbreListUseCase.execute();
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
      final newArbre = await _createArbreAndMesureUseCase.execute(
        // idArbreOrig,

        item["idPlacette"],
        item["codeEssence"],
        item["azimut"],
        item["distance"],
        item["taillis"],
        item["observation"],
        item["idCycle"],
        item["numCycle"],
        item["diametre1"],
        item["diametre2"],
        item["type"],
        item["hauteurTotale"],
        item["hauteurBranche"],
        item["stadeDurete"],
        item["stadeEcorce"],
        item["liane"],
        item["diametreLiane"],
        item["coupe"],
        item["limite"],
        item["idNomenclatureCodeSanitaire"],
        item["codeEcolo"],
        item["refCodeEcolo"],
        item["ratioHauteur"],
        item["observationMesure"],
      );
      // _lastModifiedArbreId = newArbre.idArbreOrig;
      // _LastSelectedIdNotifier.setLastSelectedId('Arbres', newArbre.idArbreOrig);
      _lastModifiedProvider.setLastSelectedId('Arbres', newArbre.idArbreOrig);
      // final aa = state.data!.addArbre(newArbre);
      state = State.success(state.data!.addItemToList(newArbre));
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
      // convert object to Arbre

      final newArbre = await _updateArbreAndMesureUseCase.execute(
        arbre!,
        // idArbreOrig,
        item["idArbre"],
        item["idArbreOrig"],
        item["idPlacette"],
        item["codeEssence"],
        item["azimut"],
        item["distance"],
        item["taillis"],
        item["observation"],
        item["idArbreMesure"],
        item["idCycle"],
        item["numCycle"],
        item["diametre1"],
        item["diametre2"],
        item["type"],
        item["hauteurTotale"],
        item["hauteurBranche"],
        item["stadeDurete"],
        item["stadeEcorce"],
        item["liane"],
        item["diametreLiane"],
        item["coupe"],
        item["limite"],
        item["idNomenclatureCodeSanitaire"],
        item["codeEcolo"],
        item["refCodeEcolo"],
        item["ratioHauteur"],
        item["observationMesure"],
      );
      // _lastModifiedArbreId = newArbre.idArbreOrig;
      _lastModifiedProvider.setLastSelectedId('Arbres', newArbre.idArbreOrig);

      // final aa = state.data!.addArbre(newArbre);
      state = State.success(state.data!.updateItemInList(newArbre));
      _displayableListNotifier.setDisplayableList(state.data!);
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  addMesureItem(
    Arbre arbre,
    final Map item,
    // final int idArbreOrig,
  ) async {
    try {
      final newArbre = await _addArbreMesureUseCase.execute(
        // idArbreOrig,
        arbre,
        item["idCycle"],
        item["numCycle"],
        item["diametre1"],
        item["diametre2"],
        item["type"],
        item["hauteurTotale"],
        item["hauteurBranche"],
        item["stadeDurete"],
        item["stadeEcorce"],
        item["liane"],
        item["diametreLiane"],
        item["coupe"],
        item["limite"],
        item["idNomenclatureCodeSanitaire"],
        item["codeEcolo"],
        item["refCodeEcolo"],
        item["ratioHauteur"],
        item["observationMesure"],
      );
      // _lastModifiedArbreId = newArbre.idArbreOrig;
      _lastModifiedProvider.setLastSelectedId('Arbres', newArbre.idArbreOrig);

      // final aa = state.data!.addArbre(newArbre);
      state = State.success(state.data!.updateItemInList(newArbre));
      _displayableListNotifier.setDisplayableList(state.data!);
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  @override
  Future<void> deleteItem(int id) async {
    try {
      await _deleteArbreAndMesureUseCase.execute(id);
      _lastModifiedProvider.setLastSelectedId('Arbres', null);
      state = State.success(state.data!.removeItemFromList(id));
      _displayableListNotifier.setDisplayableList(state.data!);
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  Future<bool> deleteItemMesure(int idArbre, int idArbreMesure) async {
    try {
      // Find the Arbre that corresponds to the idArbre
      Arbre? targetedArbre;
      for (var arbre in state.data!.values) {
        if (arbre.idArbre == idArbre) {
          targetedArbre = arbre;
          break;
        }
      }

      if (targetedArbre == null) {
        throw Exception("Arbre not found.");
      }

      // Check if the Arbre has more than one mesure
      if (targetedArbre.arbresMesures!.values.length <= 1) {
        throw Exception("Cannot delete the only mesure of an arbre.");
      }

      // Execute the use case to delete the ArbreMesure
      await _deleteArbreMesureUseCase.execute(idArbreMesure);

      // Update the ArbreList by removing the specific ArbreMesure
      List<Arbre> updatedArbres = [];
      for (var arbre in state.data!.values) {
        if (arbre.idArbre == idArbre) {
          // Remove the ArbreMesure from the arbresMesures list
          var updatedArbreMesures = arbre.arbresMesures!.values
              .where((mesure) => mesure.idArbreMesure != idArbreMesure)
              .toList();
          // Create a new Arbre with the updated list
          var updatedArbre = arbre.copyWith(
              arbresMesures: ArbreMesureList(values: updatedArbreMesures));
          updatedArbres.add(updatedArbre);
        } else {
          updatedArbres.add(arbre);
        }
      }

      // Set the new state with the updated Arbres list
      ArbreList updatedList = ArbreList(values: updatedArbres);
      state = State.success(updatedList);
      _displayableListNotifier.setDisplayableList(updatedList);

      // Update last modified ID
      _lastModifiedProvider.setLastSelectedId('Arbres', null);
      return true;
    } on Exception catch (e) {
      state = State.error(e);
      print(e.toString()); // For debugging purposes
      // Return false if an exception occurs
      return false;
    }
  }

  int? getLastModifiedArbreId() {
    return _lastModifiedArbreId;
  }

  // void setCoupeOfLastCycle(final String value){
  //   try{
  //     await _changeCoupeLastMesure.execute(
  //         value
  //     );
  //     // final aa = state.data!.addArbre(newArbre);
  //   } on Exception catch (e) {
  //     state = State.error(e);
  //   }
  // }

  void setArbreList(ArbreList arbreList) {
    state = State.success(arbreList);
  }

  ArbreList getArbreList() {
    return state.data!;
  }

  // updateArbre(final Arbre newArbre) async {
  //   try {
  //     await _updateArbreUseCase.execute(
  //       newArbre.id,
  //       newArbre.title,
  //       newArbre.description,
  //       newArbre.isCompleted,
  //       newArbre.dueDate,
  //     );
  //     state = State.success(state.data!.updateArbre(newArbre));
  //   } on Exception catch (e) {
  //     state = State.error(e);
  //   }
  // }

  // deleteArbre(final ArbreId id) async {
  //   try {
  //     await _deleteArbreUseCase.execute(id);
  //     state = State.success(state.data!.removeArbreById(id));
  //   } on Exception catch (e) {
  //     state = State.error(e);
  //   }
  // }
}
