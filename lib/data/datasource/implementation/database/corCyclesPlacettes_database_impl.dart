import 'package:dendro3/data/datasource/implementation/database/arbres_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/data/datasource/implementation/database/global_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/regenerations_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/transects_database_impl.dart';
import 'package:dendro3/data/datasource/interface/database/corCyclesPlacettes_database.dart';
import 'package:dendro3/data/entity/corCyclesPlacettes_entity.dart';
import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CorCyclesPlacettesDatabaseImpl implements CorCyclesPlacettesDatabase {
  static const _tableName = 'cor_cycles_placettes';
  static const _columnId = 'id_cycle_placette';

  Future<Database> get database async {
    return await DB.instance.database;
  }

  // @override
  // Future<PlacetteListEntity> allCorCyclesPlacettes() async {
  //   final db = await database;
  //   return db.query(_tableName);
  // }

  static Future<void> insertCorCyclePlacette(
      Batch batch, final CorCyclePlacetteEntity corCyclePlacette) async {
    final corCyclePlacetteInsertProperties = {
      for (var property in corCyclePlacette.keys.where((k) =>
          k == 'id_cycle_placette' ||
          k == 'id_cycle' ||
          k == 'id_placette' ||
          k == 'date_releve' ||
          k == 'date_intervention' ||
          k == 'annee' ||
          k == 'nature_intervention' ||
          k == 'gestion_placette' ||
          k == 'id_nomenclature_castor' ||
          k == 'id_nomenclature_frottis' ||
          k == 'id_nomenclature_boutis' ||
          k == 'recouv_herbes_basses' ||
          k == 'recouv_herbes_hautes' ||
          k == 'recouv_buissons' ||
          k == 'recouv_arbres'))
        property: corCyclePlacette[property]
    };

    batch.insert(_tableName, corCyclePlacetteInsertProperties,
        conflictAlgorithm: ConflictAlgorithm.replace);

    corCyclePlacette['transects']
        .map((transect) async =>
            {await TransectsDatabaseImpl.insertTransect(batch, transect)})
        .toList();
    corCyclePlacette['regenerations']
        .map((regeneration) async => {
              await RegenerationsDatabaseImpl.insertRegeneration(
                  batch, regeneration)
            })
        .toList();
  }

  static Future<List<CorCyclePlacetteEntity>> getPlacetteCorCyclesPlacettes(
      Database db, final int placetteId) async {
    return await db
        .query(_tableName, where: 'id_placette = ?', whereArgs: [placetteId]);
  }

  @override
  // Function called when one cor_cycle_placette is added (not add  transect or regeneration)
  Future<CorCyclePlacetteEntity> addCorCyclePlacette(
      final CorCyclePlacetteEntity corCyclePlacette) async {
    final db = await database;
    late final CorCyclePlacetteEntity corCyclePlacetteEntity;

    await db.transaction((txn) async {
      int? maxId = Sqflite.firstIntValue(
          await txn.rawQuery('SELECT MAX($_columnId) FROM $_tableName'));

      corCyclePlacette[_columnId] = maxId! + 1;

      await txn.insert(
        _tableName,
        corCyclePlacette,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      final results = await txn
          .query(_tableName, where: '$_columnId = ?', whereArgs: [maxId! + 1]);
      corCyclePlacetteEntity = results.first;
    });
    return corCyclePlacetteEntity;
  }

  // @override
  // Future<void> updatePlacette(final PlacetteEntity placette) async {
  //   final db = await database;
  //   final int id = placette['id'];
  //   await db.update(
  //     _tableName,
  //     placette,
  //     where: '$_columnId = ?',
  //     whereArgs: [id],
  //   );
  // }

  // @override
  // Future<void> deletePlacette(final int id) async {
  //   final db = await database;
  //   await db.delete(
  //     _tableName,
  //     where: '$_columnId = ?',
  //     whereArgs: [id],
  //   );
  // }

}
