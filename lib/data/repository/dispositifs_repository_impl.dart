import 'package:dendro3/core/helpers/sync_objects.dart';
import 'package:dendro3/data/datasource/interface/database/dispositifs_database.dart';
import 'package:dendro3/data/datasource/interface/api/dispositifs_api.dart';
import 'package:dendro3/data/entity/dispositifs_entity.dart';
import 'package:dendro3/data/mapper/dispositif_list_mapper.dart';
import 'package:dendro3/data/mapper/dispositif_mapper.dart';
import 'package:dendro3/domain/model/dispositif.dart';
// import 'package:dendro3/domain/model/dispositif_id.dart';
import 'package:dendro3/domain/model/dispositif_list.dart';
import 'package:dendro3/domain/repository/dispositifs_repository.dart';
import 'package:dendro3/domain/repository/local_storage_repository.dart';

class DispositifsRepositoryImpl implements DispositifsRepository {
  final DispositifsDatabase database;
  final DispositifsApi api;
  final LocalStorageRepository _localStorageRepository;

  const DispositifsRepositoryImpl(
      this.database, this.api, this._localStorageRepository);

  @override
  Future<DispositifList> getDispositifList() async {
    final dispositifListEntity = await database.allDispositifs();
    return DispositifListMapper.transformToModel(dispositifListEntity);
  }

  @override
  Future<DispositifList> getDispositifListFromAPI() async {
    final dispositifListEntity = await api.getAllDispositifs();
    return DispositifListMapper.transformFromApiToModel(dispositifListEntity);
  }

  @override
  Future<DispositifList> getUserDispositifListFromAPI(
    final int userId,
  ) async {
    final dispositifListEntity = await api.getUserDispositifs(userId);
    return DispositifListMapper.transformFromApiToModel(dispositifListEntity);
  }

  @override
  // Avoir les dispositifs d'un utilisateur via l'api, et si l'api ne répond pas, via la bdd
  Future<DispositifList> getUserDispositifListFromDB(
    final int userId,
  ) async {
    final dispositifListEntity = await database.getUserDispositifs(userId);
    return DispositifListMapper.transformToModel(dispositifListEntity);
  }

  Future<Dispositif> downloadDispositifData(
    final int dispositifId,
    Function(double) onProgressUpdate,
  ) async {
    await _localStorageRepository.setLastSyncTimeForDispositif(
        dispositifId, DateTime.now());

    final dispositifEntity =
        await api.getDispositifFromId(dispositifId, onProgressUpdate);
    final mappedDispositif =
        DispositifMapper.transformFromApiToModel(dispositifEntity["data"]);

    final dispositifEntityFromDB = await database
        .insertDispositif(DispositifMapper.transformToMap(mappedDispositif));
    return DispositifMapper.transformToModel(dispositifEntityFromDB);
  }

  @override
  Future<Dispositif> getDispositif(
    final int dispositifId,
  ) async {
    final dispositifEntityFromDB = await database.getDispositif(dispositifId);
    return DispositifMapper.transformFromDBToModel(dispositifEntityFromDB);
  }

  @override
  Future<Dispositif> createDispositif(
    final String name,
    final int idOrganisme,
    final bool alluvial,
  ) async {
    final dispositifEntity = await database
        .insertDispositif(DispositifMapper.transformToNewEntityMap(
      name,
      idOrganisme,
      alluvial,
    ));
    return DispositifMapper.transformToModel(dispositifEntity);
  }

  @override
  Future<void> updateDispositif(
    final int id,
    final String name,
    final int idOrganisme,
    final bool alluvial,
  ) async {
    final dispositif = Dispositif(
      id: id,
      name: name,
      idOrganisme: idOrganisme,
      alluvial: alluvial,
    );
    await database
        .updateDispositif(DispositifMapper.transformToMap(dispositif));
  }

  @override
  Future<void> deleteDispositif(final int id) async =>
      await database.deleteDispositif(id);

  @override
  Future<TaskResult> exportDispositifData(
      int idDispositif, String? lastSyncTime) async {
    // get dispositif and all data linked to the dispositif
    DispositifEntity data =
        await database.getDispositifAllData(idDispositif, lastSyncTime!);

    return await api.exportDispositifData(data);
  }
}
