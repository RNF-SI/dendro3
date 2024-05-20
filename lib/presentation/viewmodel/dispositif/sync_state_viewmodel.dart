import 'package:dendro3/core/helpers/export_objects.dart';
import 'package:dendro3/core/helpers/sync_count.dart';
import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/usecase/export_dispositif_data_usecase.dart';
import 'package:dendro3/domain/usecase/get_last_sync_time_for_dispositif.dart';
import 'package:dendro3/domain/usecase/sync_dispositif_from_staging_server_usecase.dart';
import 'package:dendro3/presentation/viewmodel/last_selected_Id_notifier.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final syncStateProvider = StateNotifierProvider.autoDispose
    .family<SyncStateNotifier, SyncState, int>((ref, dispositifId) {
  return SyncStateNotifier(
      dispositifId,
      ref.watch(exportDispositifDataUseCaseProvider),
      ref.watch(syncDispositifFromStagingServerUseCaseProvider),
      ref.watch(getLastSyncTimeForDispositifUseCaseProvider));
});

class SyncStateNotifier extends StateNotifier<SyncState> {
  final ExportDispositifDataUseCase _exportDispositifDataUseCase;
  final SyncDispositifFromStagingServerUseCase
      _syncDispositifFromStagingServerUseCase;
  final GetLastSyncTimeForDispositifUseCase
      _getLastSyncTimeForDispositifUseCase;

  SyncStateNotifier(
    int dispositifId,
    this._exportDispositifDataUseCase,
    this._syncDispositifFromStagingServerUseCase,
    this._getLastSyncTimeForDispositifUseCase,
  ) : super(SyncState.initial()) {
    _startSync(dispositifId);
  }

  void _startSync(int dispositifId) async {
    state = SyncState.loading();
    try {
      final String? lastSyncTime =
          await _getLastSyncTimeForDispositifUseCase.execute(dispositifId);

      // Execute the synchronization use case
      final syncResults = await _syncDispositifFromStagingServerUseCase.execute(
        dispositifId,
        lastSyncTime,
      );
      final exportResults = await _exportDispositifDataUseCase.execute(
        dispositifId,
        lastSyncTime,
      );
      state = SyncState.success(exportResults, syncResults);
    } catch (e) {
      state = SyncState.error(e.toString());
    }
  }
}

// Define the state classes
class SyncState {
  final ExportResults? results;
  final SyncCounts? counts;
  final String? error;
  final bool isLoading;

  SyncState.initial()
      : results = null,
        counts = null,
        error = null,
        isLoading = false;

  SyncState.loading()
      : results = null,
        counts = null,
        error = null,
        isLoading = true;

  SyncState.success(this.results, this.counts)
      : error = null,
        isLoading = false;

  SyncState.error(this.error)
      : results = null,
        counts = null,
        isLoading = false;
}
