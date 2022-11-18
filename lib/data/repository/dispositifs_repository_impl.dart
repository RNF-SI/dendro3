import 'package:dendro3/data/datasource/interface/dispositifs_database.dart';
import 'package:dendro3/data/mapper/dispositif_list_mapper.dart';
import 'package:dendro3/data/mapper/dispositif_mapper.dart';
import 'package:dendro3/domain/model/dispositif.dart';
// import 'package:dendro3/domain/model/dispositif_id.dart';
import 'package:dendro3/domain/model/dispositif_list.dart';
import 'package:dendro3/domain/repository/dispositifs_repository.dart';

class DispositifsRepositoryImpl implements DispositifsRepository {
  final DispositifsDatabase database;

  const DispositifsRepositoryImpl(this.database);

  @override
  Future<DispositifList> getDispositifList() async {
    final dispositifListEntity = await database.allDispositifs();
    return DispositifListMapper.transformToModel(dispositifListEntity);
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
}
