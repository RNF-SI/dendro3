import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/usecase/complete_cycle_placette_created_usecase.dart';
import 'package:dendro3/domain/usecase/get_cor_cycle_placette_local_storage_provider.dart';
import 'package:dendro3/domain/usecase/set_cycle_placette_created_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CorCyclePlacetteStatus { finished, started, notStarted }

final corCyclePlacetteLocalStorageStatusStateNotifierProvider =
    StateNotifierProvider<CorCyclePlacetteLocalStorageStatusNotifier,
        List<String>>((ref) {
  return CorCyclePlacetteLocalStorageStatusNotifier(
    ref.watch(getCorCyclePlacetteLocalStorageUseCaseprovider),
    ref.watch(setCyclePlacetteCreatedUseCaseProvider),
    ref.watch(completeCyclePlacetteCreatedUseCaseProvider),
  );
});

class CorCyclePlacetteLocalStorageStatusNotifier
    extends StateNotifier<List<String>> {
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
    List<String> inProgressIds =
        _getCyclePlacetteLocalStorageUseCaseProvider.execute();
    state = inProgressIds;
  }

  Future<void> completeCycle(String idCyclePlacette) async {
    await _completeCyclePlacetteCreatedUseCaseProvider.execute(idCyclePlacette);
    state = List.from(state)..remove(idCyclePlacette);
  }

  bool isCyclePlacetteInProgress(String idCyclePlacette) =>
      state.contains(idCyclePlacette);

  Future<void> startCyclePlacette(String idCyclePlacette) async {
    await _setCyclePlacetteCreatedUseCaseProvider.execute(idCyclePlacette);
    state = List.from(state)..add(idCyclePlacette);
  }

  refreshList() {
    state = state;
  }

  void reinitializeList() {
    List<String> inProgressIds =
        _getCyclePlacetteLocalStorageUseCaseProvider.execute();
    state = inProgressIds; // Notify listeners about the change
  }
}
