import 'package:dendro3/core/helpers/sync_objects.dart';
import 'package:dendro3/domain/model/dispositif.dart';
import 'package:dendro3/domain/model/dispositif_list.dart';

abstract class DispositifsRepository {
  Future<DispositifList> getDispositifList();
  Future<DispositifList> getDispositifListFromAPI();
  Future<DispositifList> getUserDispositifListFromAPI(
    final int id,
  );
  Future<DispositifList> getUserDispositifListFromDB(
    final int id,
  );
  Future<void> downloadDispositifData(
    final int id,
  );
  Future<Dispositif> createDispositif(
    final String name,
    final int idOrganisme,
    final bool alluvial,
  );
  Future<void> updateDispositif(
    final int id,
    final String name,
    final int idOrganisme,
    final bool alluvial,
  );
  Future<void> deleteDispositif(final int id);

  Future<Dispositif> getDispositif(
    final int id,
  );

  Future<TaskResult> exportDispositifData(int idDispositif);
}
