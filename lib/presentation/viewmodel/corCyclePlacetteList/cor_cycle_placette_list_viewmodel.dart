import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/corCyclePlacette_list.dart';
import 'package:dendro3/domain/usecase/create_cor_cycle_placette_usecase.dart';
// import 'package:dendro3/domain/model/arbre_list.dart';
// import 'package:dendro3/domain/usecase/create_arbre_and_mesure_usecase.dart';
import 'package:dendro3/presentation/state/state.dart';
import 'package:dendro3/presentation/viewmodel/baseList/base_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/placette/saisie_placette_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final corCyclePlacetteListProvider = Provider<CorCyclePlacetteList>((ref) {
  final state = ref.watch(corCyclePlacetteListViewModelStateNotifierProvider);
  return state.data ?? CorCyclePlacetteList.empty();
});

final corCyclePlacetteListViewModelStateNotifierProvider =
    StateNotifierProvider<CorCyclePlacetteListViewModel,
        State<CorCyclePlacetteList>>((ref) {
  return CorCyclePlacetteListViewModel(
      // ref.watch(getArbreListUseCaseProvider),
      ref.watch(createCorCyclePlacetteUseCaseProvider)
      // ref.watch(createArbreAndMesureUseCaseProvider),
      // ref.watch(updateArbreUseCaseProvider),
      // ref.watch(deleteArbreUseCaseProvider),
      // arbreListe,
      );
});

class CorCyclePlacetteListViewModel
    extends BaseListViewModel<State<CorCyclePlacetteList>> {
  // final GetArbreListUseCase _getArbreListUseCase;
  final CreateCorCyclePlacetteUseCase _createCorCyclePlacetteUseCase;
  // final UpdateArbreUseCase _updateArbreUseCase;
  // final DeleteArbreUseCase _deleteArbreUseCase;

  CorCyclePlacetteListViewModel(
    // this._getArbreListUseCase,
    this._createCorCyclePlacetteUseCase,
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

  @override
  addItem(
    final Map item,
  ) async {
    try {
      final newCorCyclePlacette = await _createCorCyclePlacetteUseCase.execute(
        item['idCycle'],
        item['idPlacette'],
        item['dateReleve'],
        item['dateIntervention'],
        item['annee'],
        item['natureIntervention'],
        item['gestionPlacette'],
        item['idNomenclatureCastor'],
        item['idNomenclatureFrottis'],
        item['idNomenclatureBoutis'],
        item['recouvHerbesBasses'],
        item['recouvHerbesHautes'],
        item['recouvBuissons'],
        item['recouvArbres'],
      );
      state = State.success(state.data!.addItemToList(newCorCyclePlacette));
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  @override
  updateItem(
    final Map item, {
    Arbre? arbre,
    BmSup30? bmSup30,
  }
      // final int idArbreOrig,
      ) async {}

//   addArbre(
//     // final int idArbreOrig,
//     // Propriétés arbre
//     final int idPlacette,
//     final String codeEssence,
//     final double azimut,
//     // final String title,
//     // final String description,
//     // final bool isCompleted,
//     // final DateTime dueDate,
//   ) async {
//     try {
//       final newArbre = await _createArbreAndMesureUseCase.execute(
//         // idArbreOrig,
//         idPlacette,
//         codeEssence,
//         azimut,
//       );
//       // final aa = state.data!.addArbre(newArbre);
//       state = State.success(state.data!.addArbre(newArbre));
//     } on Exception catch (e) {
//       state = State.error(e);
//     }
//   }

  // Create a new corCyclePlacette
  startCycleForPlacette() {
    // try {
    //   final newCorCyclePlacette = await _createCorCyclePlacetteUseCase.execute(
    //     // idArbreOrig,
    //     // idPlacette,
    //     // codeEssence,
    //     // azimut,
    //   );
    // }
  }

  void setCorCyclePlacetteList(CorCyclePlacetteList corCyclePlacetteList) {
    state = State.success(corCyclePlacetteList);
  }

  @override
  Future<void> deleteItem(int id) {
    // TODO: implement deleteItem
    throw UnimplementedError();
  }

//   ArbreList getArbreList() {
//     return state.data!;
//   }

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
