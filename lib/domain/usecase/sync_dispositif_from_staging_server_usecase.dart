import 'package:dendro3/core/helpers/sync_results_object.dart';

abstract class SyncDispositifFromStagingServerUseCase {
  Future<SyncResults> execute(final int id, final String? lastSyncTime);
}
