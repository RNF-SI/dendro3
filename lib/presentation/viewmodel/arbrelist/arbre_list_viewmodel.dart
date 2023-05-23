// import 'package:clean_architecture_todo_app/domain/domain_module.dart';
// import 'package:clean_architecture_todo_app/domain/model/todo.dart';
// import 'package:clean_architecture_todo_app/domain/model/todo_id.dart';
// import 'package:clean_architecture_todo_app/domain/model/todo_list.dart';
// import 'package:clean_architecture_todo_app/domain/usecase/create_todo_usecase.dart';
// import 'package:clean_architecture_todo_app/domain/usecase/delete_todo_usecase.dart';
// import 'package:clean_architecture_todo_app/domain/usecase/get_todo_list_usecase.dart';
// import 'package:clean_architecture_todo_app/domain/usecase/update_todo_usecase.dart';
// import 'package:clean_architecture_todo_app/presentation/state/state.dart';
// import 'package:clean_architecture_todo_app/presentation/viewmodel/todolist/filter_kind_viewmodel.dart';
import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/arbre_list.dart';
import 'package:dendro3/domain/usecase/create_arbre_usecase.dart';
import 'package:dendro3/presentation/state/state.dart';
import 'package:dendro3/presentation/viewmodel/placette/saisie_placette_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final arbreListViewModelStateNotifierProvider = StateNotifierProvider
    .autoDispose
    .family<ArbreListViewModel, State<ArbreList>, int>((ref, placetteId) {
  final placetteViewModel =
      ref.watch(saisiePlacetteViewModelProvider(placetteId));
  final arbreListe = placetteViewModel.data?.arbres ?? ArbreList.empty();

  return ArbreListViewModel(
    // ref.watch(getArbreListUseCaseProvider),
    ref.watch(createArbreUseCaseProvider),
    // ref.watch(updateArbreUseCaseProvider),
    // ref.watch(deleteArbreUseCaseProvider),
    arbreListe,
  );
});

class ArbreListViewModel extends StateNotifier<State<ArbreList>> {
  // final GetArbreListUseCase _getArbreListUseCase;
  final CreateArbreUseCase _createArbreUseCase;
  // final UpdateArbreUseCase _updateArbreUseCase;
  // final DeleteArbreUseCase _deleteArbreUseCase;

  ArbreListViewModel(
      // this._getArbreListUseCase,
      this._createArbreUseCase,
      // this._updateArbreUseCase,
      // this._deleteArbreUseCase,
      final ArbreList arbreListe)
      : super(State.success(arbreListe)) {
    state = State.success(arbreListe);
    // _getArbreList();
  }

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
    final int idPlacette,
    final String codeEssence,
    final double azimut,
    final double distance,
    final bool taillis,
    final String observation,

    // final String title,
    // final String description,
    // final bool isCompleted,
    // final DateTime dueDate,
  ) async {
    try {
      final newArbre = await _createArbreUseCase.execute(
        // idArbreOrig,
        idPlacette,
        codeEssence,
        azimut,
        distance,
        taillis,
        observation,
      );
      final aa = state.data!.addArbre(newArbre);
      state = State.success(state.data!.addArbre(newArbre));
    } on Exception catch (e) {
      state = State.error(e);
    }
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
