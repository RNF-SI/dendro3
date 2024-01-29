import 'package:dendro3/data/entity/dispositifs_entity.dart';

abstract class DispositifsApi {
  Future<DispositifListEntity> getAllDispositifs();
  Future<DispositifListEntity> getUserDispositifs(final int userId);
  Future<DispositifEntity> getDispositifFromId(final int dispId);
  Future<void> exportDispositifData(final DispositifEntity data);
}
