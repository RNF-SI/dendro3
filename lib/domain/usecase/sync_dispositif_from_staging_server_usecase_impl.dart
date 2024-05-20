import 'package:dendro3/core/helpers/export_objects.dart';
import 'package:dendro3/core/helpers/sync_count.dart';
import 'package:dendro3/core/helpers/sync_results_object.dart';
import 'package:dendro3/domain/repository/dispositifs_repository.dart';
import 'package:dendro3/domain/repository/local_storage_repository.dart';
import 'package:dendro3/domain/usecase/sync_dispositif_from_staging_server_usecase.dart';

class SyncDispositifFromStagingServerUseCaseImpl
    implements SyncDispositifFromStagingServerUseCase {
  final DispositifsRepository _repository;
  final LocalStorageRepository _localStorageRepository;

  SyncDispositifFromStagingServerUseCaseImpl(
      this._repository, this._localStorageRepository);

  Future<SyncCounts> execute(
      final int dispId, final String? lastSyncTime) async {
    SyncCounts results = await _repository.syncDispositifsFromStagingServer(
      dispId,
      lastSyncTime,
    );
    await _localStorageRepository.setLastSyncTimeForDispositif(
        dispId, DateTime.now());
    return results;
  }
}
