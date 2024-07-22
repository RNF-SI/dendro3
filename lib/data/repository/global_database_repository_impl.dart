import 'package:dendro3/data/datasource/interface/api/global_api.dart';
import 'package:dendro3/data/datasource/interface/database/global_database.dart';
import 'package:dendro3/data/entity/essences_entity.dart';
import 'package:dendro3/data/entity/nomenclatures_entity.dart';
import 'package:dendro3/domain/repository/global_database_repository.dart';

class GlobalDatabaseRepositoryImpl implements GlobalDatabaseRepository {
  final GlobalDatabase database;
  final GlobalApi api;

  const GlobalDatabaseRepositoryImpl(this.database, this.api);

  @override
  Future<void> initDatabase() async {
    try {
      await database.initDatabase();
      // Import essences only if table is empty
      if (await database.checkBibEssenceEmpty()) {
        EssenceListEntity bibEssences = await api.getBibEssences();
        await database.insertEssences(bibEssences);
      }
      // Import nomenclatures types only if table is empty
      if (await database.checkBibNomenclaturesTypesEmpty()) {
        await database
            .insertBibNomenclaturesTypes(await api.getBibNomenclaturesTypes());
      }
      // Import nomenclatures only if table is empty
      if (await database.checkNomenclaturesEmpty()) {
        await database.insertNomenclatures(await api.getNomenclatures());
      }
    } catch (e) {
      throw Exception('Failed to initialize database: $e');
    }
  }

  @override
  Future<void> deleteDatabase() async {
    try {
      await database.deleteAndReinitializeCurrentDatabase();
    } catch (e) {
      throw Exception('Failed to delete database: $e');
    }
  }

  @override
  Future<void> exportDatabase() async {
    try {
      await database.exportDatabase();
    } catch (e) {
      throw Exception('Failed to export database: $e');
    }
  }

  @override
  Future<void> refreshNomenclatures() async {
    try {
      NomenclatureListEntity nomenclatures = await api.refreshNomenclatures();
      await database.refreshNomenclatures(nomenclatures);
    } catch (e) {
      throw Exception('Failed to refresh nomenclatures: $e');
    }
  }
}
