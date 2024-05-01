import 'package:dendro3/core/helpers/sync_objects.dart';
import 'package:dendro3/data/entity/dispositifs_entity.dart';

abstract class DispositifsApi {
  Future<DispositifListEntity> getAllDispositifs();
  Future<DispositifListEntity> getUserDispositifs(final int userId);
  Future<DispositifEntity> getDispositifFromId(
    final int dispId,
    Function(double) onProgressUpdate,
  );
  Future<TaskResult> exportDispositifData(final DispositifEntity data);
}
