import 'package:dendro3/core/helpers/sync_results_object.dart';
import 'package:dendro3/data/entity/dispositifs_entity.dart';

abstract class DispositifsDatabase {
  Future<DispositifListEntity> allDispositifs();
  Future<DispositifEntity> insertDispositif(
      final DispositifEntity dispositifEntity);
  Future<void> updateDispositif(final DispositifEntity dispositifEntity);
  Future<void> deleteDispositif(final int id);
  Future<DispositifListEntity> getUserDispositifs(final int id);
  Future<DispositifEntity> getDispositif(final int id);
  Future<DispositifEntity> getDispositifAllData(
    final int id,
    String lastSyncTime,
  );
  Future<void> insertOrUpdateDispositifWithData(final SyncResults syncResults);
}
