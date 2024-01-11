import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/corCyclePlacette_list.dart';
import 'package:dendro3/domain/usecase/complete_cycle_placette_created_usecase.dart';
import 'package:dendro3/domain/usecase/get_cor_cycle_placette_local_storage_provider.dart';
import 'package:dendro3/domain/usecase/is_cycle_placette_created_usecase.dart';
import 'package:dendro3/domain/usecase/set_cycle_placette_created_usecase.dart';
import 'package:dendro3/presentation/viewmodel/corCyclePlacetteList/cor_cycle_placette_list_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CorCyclePlacetteStatus { finished, started, notStarted }

final corCyclePlacetteLocalStorageStatusStateNotifierProvider =
    StateNotifierProvider<CorCyclePlacetteLocalStorageStatusNotifier,
        List<int>>((ref) {
  return CorCyclePlacetteLocalStorageStatusNotifier(
    ref.watch(getCorCyclePlacetteLocalStorageUseCaseprovider),
    ref.watch(setCyclePlacetteCreatedUseCaseProvider),
    ref.watch(completeCyclePlacetteCreatedUseCaseProvider),
  );
});

class CorCyclePlacetteLocalStorageStatusNotifier
    extends StateNotifier<List<int>> {
  final GetInProgressCorCyclePlacetteLocalStorageUseCase
      _getCyclePlacetteLocalStorageUseCaseProvider;
  final SetCyclePlacetteCreatedUseCase _setCyclePlacetteCreatedUseCaseProvider;

  final CompleteCyclePlacetteCreatedUseCase
      _completeCyclePlacetteCreatedUseCaseProvider;

  CorCyclePlacetteLocalStorageStatusNotifier(
    this._getCyclePlacetteLocalStorageUseCaseProvider,
    this._setCyclePlacetteCreatedUseCaseProvider,
    this._completeCyclePlacetteCreatedUseCaseProvider,
  ) : super([]) {
    _initializeList();
  }

  void _initializeList() {
    List<int> inProgressIds =
        _getCyclePlacetteLocalStorageUseCaseProvider.execute();
    state = inProgressIds;
  }

  Future<void> completeCycle(int idCyclePlacette) async {
    await _completeCyclePlacetteCreatedUseCaseProvider.execute(idCyclePlacette);
    state = List.from(state)..remove(idCyclePlacette);
  }

  bool isCyclePlacetteInProgress(int idCyclePlacette) =>
      state.contains(idCyclePlacette);

  Future<void> startCyclePlacette(int idCyclePlacette) async {
    await _setCyclePlacetteCreatedUseCaseProvider.execute(idCyclePlacette);
    state = List.from(state)..add(idCyclePlacette);
  }

  refreshList() {
    state = state;
  }
}
