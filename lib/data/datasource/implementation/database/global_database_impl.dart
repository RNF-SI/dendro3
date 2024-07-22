import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/data/datasource/interface/database/global_database.dart';
import 'package:dendro3/data/entity/essences_entity.dart';
import 'package:dendro3/data/entity/nomenclatures_entity.dart';
import 'package:dendro3/data/entity/nomencluresTypes_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class GlobalDatabaseImpl implements GlobalDatabase {
  Future<Database> get database async {
    return await DB.instance.database;
  }

  @override
  Future<Database> initDatabase() async {
    return await DB.instance.database;
  }

  @override
  Future<void> insertEssences(EssenceListEntity essenceListEntity) async {
    final db = await database;
    await db.transaction((txn) async {
      Batch batch = txn.batch();

      essenceListEntity.map((essenceEntity) async {
        final essenceInsertProperties = {
          for (var property in essenceEntity.keys.where((k) =>
              k == 'code_essence' ||
              k == 'cd_nom' ||
              k == 'nom' ||
              k == 'nom_latin' ||
              k == 'ess_reg' ||
              k == 'couleur'))
            property: essenceEntity[property]
        };
        batch.insert(
          'bib_essences',
          essenceInsertProperties,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }).toList();
      await batch.commit();
    });
  }

  @override
  Future<bool> checkBibEssenceEmpty() async {
    final db = await database;
    final tempEssence = await db.query('bib_essences', limit: 1);
    return tempEssence.isEmpty ? true : false;
  }

  @override
  Future<bool> checkBibNomenclaturesTypesEmpty() async {
    final db = await database;
    final tempNomenclatureType =
        await db.query('bib_nomenclatures_types', limit: 1);
    return tempNomenclatureType.isEmpty ? true : false;
  }

  @override
  Future<bool> checkNomenclaturesEmpty() async {
    final db = await database;
    final tempNomenclature = await db.query('t_nomenclatures', limit: 1);
    return tempNomenclature.isEmpty ? true : false;
  }

  @override
  Future<void> insertBibNomenclaturesTypes(
      NomenclatureTypeListEntity nomenclatureTypeListEntity) async {
    final db = await database;
    await db.transaction((txn) async {
      Batch batch = txn.batch();

      nomenclatureTypeListEntity.map((nomenclatureTypeEntity) async {
        final nomenclatureTypeInsertProperties = {
          for (var property in nomenclatureTypeEntity.keys.where((k) =>
              k == 'id_type' ||
              k == 'mnemonique' ||
              k == 'label_default' ||
              k == 'definition_default' ||
              k == 'label_fr' ||
              k == 'definition_fr' ||
              k == 'label_en' ||
              k == 'definition_en' ||
              k == 'label_es' ||
              k == 'definition_es' ||
              k == 'label_de' ||
              k == 'definition_de' ||
              k == 'label_it' ||
              k == 'definition_it' ||
              k == 'source' ||
              k == 'statut'))
            property: nomenclatureTypeEntity[property]
        };
        batch.insert(
          'bib_nomenclatures_types',
          nomenclatureTypeInsertProperties,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }).toList();
      await batch.commit();
    });
  }

  @override
  Future<void> insertNomenclatures(
      NomenclatureListEntity nomenclatureListEntity) async {
    final db = await database;
    await db.transaction((txn) async {
      Batch batch = txn.batch();

      nomenclatureListEntity.map((nomenclatureEntity) async {
        final nomenclatureInsertProperties = {
          for (var property in nomenclatureEntity.keys.where((k) =>
              k == 'id_nomenclature' ||
              k == 'id_type' ||
              k == 'cd_nomenclature' ||
              k == 'mnemonique' ||
              k == 'label_default' ||
              k == 'definition_default' ||
              k == 'label_fr' ||
              k == 'definition_fr' ||
              k == 'label_en' ||
              k == 'definition_en' ||
              k == 'label_es' ||
              k == 'definition_es' ||
              k == 'label_de' ||
              k == 'definition_de' ||
              k == 'label_it' ||
              k == 'definition_it' ||
              k == 'source' ||
              k == 'statut' ||
              k == 'id_broader' ||
              k == 'hierarchy' ||
              k == 'active'))
            property: nomenclatureEntity[property]
        };
        batch.insert(
          't_nomenclatures',
          nomenclatureInsertProperties,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }).toList();
      await batch.commit();
    });
  }

  @override
  Future<void> deleteAndReinitializeCurrentDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path =
        join(databasesPath, DB.databaseName); // Use the constant from DB class

    // Delete the database
    await deleteDatabase(path);

    DB.setDatabaseNull();

    // Reinitialize the database
    await DB.instance.database;
  }

  @override
  Future<void> exportDatabase() async {
    await DB.instance.exportDatabase();
  }

  @override
  Future<void> refreshNomenclatures(
      NomenclatureListEntity nomenclatureListEntity) async {
    final db = await database;
    await db.transaction((txn) async {
      Batch batch = txn.batch();

      nomenclatureListEntity.map((nomenclatureEntity) async {
        final nomenclatureInsertProperties = {
          for (var property in nomenclatureEntity.keys.where((k) =>
              k == 'id_nomenclature' ||
              k == 'id_type' ||
              k == 'cd_nomenclature' ||
              k == 'mnemonique' ||
              k == 'label_default' ||
              k == 'definition_default' ||
              k == 'label_fr' ||
              k == 'definition_fr' ||
              k == 'label_en' ||
              k == 'definition_en' ||
              k == 'label_es' ||
              k == 'definition_es' ||
              k == 'label_de' ||
              k == 'definition_de' ||
              k == 'label_it' ||
              k == 'definition_it' ||
              k == 'source' ||
              k == 'statut' ||
              k == 'id_broader' ||
              k == 'hierarchy' ||
              k == 'active'))
            property: nomenclatureEntity[property]
        };
        batch.insert(
          't_nomenclatures',
          nomenclatureInsertProperties,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }).toList();
      await batch.commit();
    });
  }
}
