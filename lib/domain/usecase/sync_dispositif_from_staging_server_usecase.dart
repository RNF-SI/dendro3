import 'package:dendro3/core/helpers/sync_count.dart';
import 'package:dendro3/core/helpers/sync_results_object.dart';

abstract class SyncDispositifFromStagingServerUseCase {
  Future<SyncCounts> execute(final int id, final String? lastSyncTime);
}
