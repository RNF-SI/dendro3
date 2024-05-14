import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/arbre_list.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/usecase/update_arbre_and_create_arbre_mesure_use_case.dart';
import 'package:dendro3/domain/usecase/create_arbre_and_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/delete_arbre_and_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/delete_arbre_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/update_arbre_and_mesure_usecase.dart';
import 'package:dendro3/presentation/state/state.dart';
import 'package:dendro3/presentation/viewmodel/baseList/base_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/displayable_list_notifier.dart';
import 'package:dendro3/presentation/viewmodel/last_selected_Id_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dendro3/presentation/widgets/saisie_data_table/saisie_data_table_service.dart';

final arbreListProvider = Provider<ArbreList>((ref) {
  final state = ref.watch(arbreListViewModelStateNotifierProvider);
  return state.data ?? ArbreList.empty();
});

final arbreListViewModelStateNotifierProvider =
    StateNotifierProvider<ArbreListViewModel, State<ArbreList>>((ref) {
  final lastSelectedProvider = ref.watch(lastSelectedIdProvider.notifier);
  final displayableListNotifier = ref.watch(displayableListProvider.notifier);
  final selectedMesureIndexProviderRef =
      ref.watch(selectedMesureIndexProvider.notifier);

  return ArbreListViewModel(
    // ref.watch(getArbreListUseCaseProvider),
    ref.watch(createArbreAndMesureUseCaseProvider),
    ref.watch(updateArbreAndMesureUseCaseProvider),
    ref.watch(updateArbreAndCreateArbreMesureUseCaseProvider),
    ref.watch(deleteArbreAndMesureUseCaseProvider),
    ref.watch(deleteArbreMesureUseCaseProvider),
    // ref.watch(deleteArbreUseCaseProvider),
    // arbreListe,
    lastSelectedProvider,
    displayableListNotifier,
    selectedMesureIndexProviderRef,
  );
});

class ArbreListViewModel extends BaseListViewModel<State<ArbreList>> {
  late final LastSelectedIdNotifier _lastSelectedProvider;
  late final DisplayableListNotifier _displayableListNotifier;
  late final SelectedMesureIndexNotifier _selectedMesureIndexProviderRef;

  // final Ref ref;
  // final GetArbreListUseCase _getArbreListUseCase;
  final CreateArbreAndMesureUseCase _createArbreAndMesureUseCase;
  final UpdateArbreAndMesureUseCase _updateArbreAndMesureUseCase;
  final UpdateArbreAndCreateArbreMesureUseCase
      _updateArbreAndCreateArbreMesureUseCase;
  final DeleteArbreAndMesureUseCase _deleteArbreAndMesureUseCase;
  final DeleteArbreMesureUseCase _deleteArbreMesureUseCase;
  // final DeleteArbreUseCase _deleteArbreUseCase;

  ArbreListViewModel(
    // this._getArbreListUseCase,
    this._createArbreAndMesureUseCase,
    this._updateArbreAndMesureUseCase,
    this._updateArbreAndCreateArbreMesureUseCase,
    this._deleteArbreAndMesureUseCase,
    this._deleteArbreMesureUseCase,
    // this._deleteArbreUseCase,
    // final ArbreList arbreListe
    this._lastSelectedProvider,
    this._displayableListNotifier,
    this._selectedMesureIndexProviderRef,
  ) : super(const State.init());

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
      // _LastSelectedIdNotifier.setLastSelectedId('Arbres', newArbre.idArbreOrig);
      _lastSelectedProvider.setLastSelectedId('Arbres', newArbre.idArbre);
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
      _lastSelectedProvider.setLastSelectedId('Arbres', newArbre.idArbre);

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
      final newArbre = await _updateArbreAndCreateArbreMesureUseCase.execute(
        // idArbreOrig,
        arbre,
        item["idArbre"],
        item["idArbreOrig"],
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
      _lastSelectedProvider.setLastSelectedId('Arbres', newArbre.idArbre);

      // final aa = state.data!.addArbre(newArbre);
      state = State.success(state.data!.updateItemInList(newArbre));
      _displayableListNotifier.setDisplayableList(state.data!);
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  @override
  Future<bool> deleteItem(String id, {String? idCyclePlacette}) async {
    try {
      await _deleteArbreAndMesureUseCase.execute(id);
      _lastSelectedProvider.setLastSelectedId('Arbres', null);
      state = State.success(state.data!.removeItemFromList(id));
      _selectedMesureIndexProviderRef.setSelectedMesureIndex(0);
      _displayableListNotifier.setDisplayableList(state.data!);
      return true;
    } on Exception catch (e) {
      state = State.error(e);
      return false;
    }
  }

  Future<bool> deleteItemMesure(
      String idArbre, String idArbreMesure, int idCycle, int numCycle) async {
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
      Arbre arbreAfterDeletion = await _deleteArbreMesureUseCase.execute(
        targetedArbre,
        idArbreMesure,
      );

      // Update the ArbreList by removing the specific ArbreMesure
      List<Arbre> updatedArbres = [];
      for (var arbre in state.data!.values) {
        if (arbre.idArbre == idArbre) {
          updatedArbres.add(arbreAfterDeletion);
        } else {
          updatedArbres.add(arbre);
        }
      }

      // Set the new state with the updated Arbres list
      ArbreList updatedList = ArbreList(values: updatedArbres);
      state = State.success(updatedList);
      // Remettre l'élément sélectionné à 0 pour être sûr que ce dernier existe
      _selectedMesureIndexProviderRef.setSelectedMesureIndex(0);
      _displayableListNotifier.setDisplayableList(updatedList);
      // Update last Selected ID
      _lastSelectedProvider.setLastSelectedId('Arbres', null);
      return true;
    } on Exception catch (e) {
      state = State.error(e);
      print(e.toString()); // For debugging purposes
      // Return false if an exception occurs
      return false;
    }
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
