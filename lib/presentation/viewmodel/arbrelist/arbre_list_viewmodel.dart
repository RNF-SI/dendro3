import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/arbre_list.dart';
import 'package:dendro3/domain/usecase/create_arbre_and_mesure_usecase.dart';
import 'package:dendro3/presentation/state/state.dart';
import 'package:dendro3/presentation/viewmodel/placette/saisie_placette_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final arbreListProvider = Provider<ArbreList>((ref) {
  final state = ref.watch(arbreListViewModelStateNotifierProvider);
  return state.data ?? ArbreList.empty();
});

final arbreListViewModelStateNotifierProvider =
    StateNotifierProvider<ArbreListViewModel, State<ArbreList>>((ref) {
  return ArbreListViewModel(
    // ref.watch(getArbreListUseCaseProvider),
    ref.watch(createArbreAndMesureUseCaseProvider),
    // ref.watch(updateArbreUseCaseProvider),
    // ref.watch(deleteArbreUseCaseProvider),
    // arbreListe,
  );
});

class ArbreListViewModel extends StateNotifier<State<ArbreList>> {
  // final GetArbreListUseCase _getArbreListUseCase;
  final CreateArbreAndMesureUseCase _createArbreAndMesureUseCase;
  // final UpdateArbreUseCase _updateArbreUseCase;
  // final DeleteArbreUseCase _deleteArbreUseCase;

  ArbreListViewModel(
    // this._getArbreListUseCase,
    this._createArbreAndMesureUseCase,
    // this._updateArbreUseCase,
    // this._deleteArbreUseCase,
    // final ArbreList arbreListe
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

  addArbre(
    // final int idArbreOrig,
    // Propriétés arbre
    final int idPlacette,
    final String codeEssence,
    final double azimut,
    final double distance,
    final bool taillis,
    final String observation,

    // Propriétés arbreMesure
    final int? idCycle,
    double? diametre1,
    double? diametre2,
    String? type,
    double? hauteurTotale,
    double? hauteurBranche,
    int? stadeDurete,
    int? stadeEcorce,
    String? liane,
    double? diametreLiane,
    String? coupe,
    final bool limite,
    int? idNomenclatureCodeSanitaire,
    String? codeEcolo,
    final String refCodeEcolo,
    bool? ratioHauteur,
    String? observationMesure,

    // final String title,
    // final String description,
    // final bool isCompleted,
    // final DateTime dueDate,
  ) async {
    try {
      final newArbre = await _createArbreAndMesureUseCase.execute(
        // idArbreOrig,
        idPlacette,
        codeEssence,
        azimut,
        distance,
        taillis,
        observation,
        idCycle,
        diametre1,
        diametre2,
        type,
        hauteurTotale,
        hauteurBranche,
        stadeDurete,
        stadeEcorce,
        liane,
        diametreLiane,
        coupe,
        limite,
        idNomenclatureCodeSanitaire,
        codeEcolo,
        refCodeEcolo,
        ratioHauteur,
        observationMesure,
      );
      // final aa = state.data!.addArbre(newArbre);
      state = State.success(state.data!.addArbre(newArbre));
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

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
