import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/arbre_list.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/saisisable_object.dart';
import 'package:dendro3/domain/usecase/add_arbre_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/create_arbre_and_mesure_usecase.dart';
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
  final lastModifiedProvider = ref.watch(lastModifiedIdProvider.notifier);
  final displayableListNotifier = ref.watch(displayableListProvider.notifier);

  return ArbreListViewModel(
    // ref.watch(getArbreListUseCaseProvider),
    ref.watch(createArbreAndMesureUseCaseProvider),
    ref.watch(updateArbreAndMesureUseCaseProvider),
    ref.watch(addArbreMesureUseCaseProvider),
    // ref.watch(deleteArbreUseCaseProvider),
    // arbreListe,
    lastModifiedProvider,
    displayableListNotifier,
  );
});

class ArbreListViewModel extends BaseListViewModel<State<ArbreList>> {
  late final LastModifiedIdNotifier _lastModifiedProvider;
  late final DisplayableListNotifier _displayableListNotifier;

  // final Ref ref;
  // final GetArbreListUseCase _getArbreListUseCase;
  final CreateArbreAndMesureUseCase _createArbreAndMesureUseCase;
  final UpdateArbreAndMesureUseCase _updateArbreAndMesureUseCase;
  final AddArbreMesureUseCase _addArbreMesureUseCase;
  // final DeleteArbreUseCase _deleteArbreUseCase;

  int? _lastModifiedArbreId;

  ArbreListViewModel(
    // this._getArbreListUseCase,
    this._createArbreAndMesureUseCase,
    this._updateArbreAndMesureUseCase,
    this._addArbreMesureUseCase,
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
      // _lastModifiedIdNotifier.setLastModifiedId('Arbres', newArbre.idArbreOrig);
      _lastModifiedProvider.setLastModifiedId('Arbres', newArbre.idArbreOrig);
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
      _lastModifiedProvider.setLastModifiedId('Arbres', newArbre.idArbreOrig);

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
      _lastModifiedProvider.setLastModifiedId('Arbres', newArbre.idArbreOrig);

      // final aa = state.data!.addArbre(newArbre);
      state = State.success(state.data!.updateItemInList(newArbre));
      _displayableListNotifier.setDisplayableList(state.data!);
    } on Exception catch (e) {
      state = State.error(e);
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
