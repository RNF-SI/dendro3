import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/corCyclePlacette_list.dart';
import 'package:dendro3/domain/model/arbre_list.dart';
import 'package:dendro3/domain/usecase/create_arbre_and_mesure_usecase.dart';
import 'package:dendro3/presentation/state/state.dart';
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
      // ref.watch(createArbreAndMesureUseCaseProvider),
      // ref.watch(updateArbreUseCaseProvider),
      // ref.watch(deleteArbreUseCaseProvider),
      // arbreListe,
      );
});

class CorCyclePlacetteListViewModel
    extends StateNotifier<State<CorCyclePlacetteList>> {
  // final GetArbreListUseCase _getArbreListUseCase;
//   final CreateArbreAndMesureUseCase _createArbreAndMesureUseCase;
  // final UpdateArbreUseCase _updateArbreUseCase;
  // final DeleteArbreUseCase _deleteArbreUseCase;

  CorCyclePlacetteListViewModel(
      // this._getArbreListUseCase,
      // this._createArbreAndMesureUseCase,
      // this._updateArbreUseCase,
      // this._deleteArbreUseCase,
      // final ArbreList arbreListe
      )
      : super(const State.init()) {}

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

  void setCorCyclePlacette(CorCyclePlacetteList corCyclePlacetteList) {
    state = State.success(corCyclePlacetteList);
  }

//   void setArbreList(ArbreList arbreList) {
//     state = State.success(arbreList);
//   }

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
