import 'package:dendro3/core/helpers/sync_objects.dart';
import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/usecase/export_dispositif_data_usecase.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final syncStateProvider = StateNotifierProvider.autoDispose
    .family<SyncStateNotifier, SyncState, int>((ref, dispositifId) {
  return SyncStateNotifier(
    dispositifId,
    ref.watch(exportDispositifDataUseCaseProvider),
  );
});

class SyncStateNotifier extends StateNotifier<SyncState> {
  final ExportDispositifDataUseCase _exportDispositifDataUseCase;

  SyncStateNotifier(
    int dispositifId,
    this._exportDispositifDataUseCase,
  ) : super(SyncState.initial()) {
    _startSync(dispositifId);
  }

  void _startSync(int dispositifId) async {
    state = SyncState.loading();
    try {
      // Execute the synchronization use case
      SyncResults results =
          await _exportDispositifDataUseCase.execute(dispositifId);
      state = SyncState.success(results);
    } catch (e) {
      state = SyncState.error(e.toString());
    }
  }
}

// Define the state classes
class SyncState {
  final SyncResults? results;
  final String? error;
  final bool isLoading;

  SyncState.initial()
      : results = null,
        error = null,
        isLoading = false;
  SyncState.loading()
      : results = null,
        error = null,
        isLoading = true;
  SyncState.success(this.results)
      : error = null,
        isLoading = false;
  SyncState.error(this.error)
      : results = null,
        isLoading = false;
}
