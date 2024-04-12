import 'package:dendro3/core/helpers/sync_objects.dart';
import 'package:dendro3/data/entity/dispositifs_entity.dart';

abstract class DispositifsApi {
  Future<DispositifListEntity> getAllDispositifs();
  Future<DispositifListEntity> getUserDispositifs(final int userId);
  Future<DispositifEntity> getDispositifFromId(final int dispId);
  Future<SyncResults> exportDispositifData(final DispositifEntity data);
}
