import 'package:dendro3/core/helpers/sync_results_object.dart';
import 'package:dendro3/data/datasource/implementation/database/cycles_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/data/datasource/implementation/database/placettes_database_impl.dart';
import 'package:dendro3/data/datasource/interface/database/dispositifs_database.dart';
import 'package:dendro3/data/entity/dispositifs_entity.dart';
import 'package:dendro3/data/mapper/cycle_mapper.dart';
import 'package:dendro3/data/mapper/dispositif_mapper.dart';
import 'package:dendro3/data/mapper/placette_mapper.dart';
import 'package:sqflite/sqflite.dart';

class DispositifsDatabaseImpl implements DispositifsDatabase {
  static const _tableName = 't_dispositifs';
  static const _columnId = 'id_dispositif';

  Future<Database> get database async {
    return await DB.instance.database;
  }

  @override
  Future<DispositifListEntity> allDispositifs() async {
    final db = await database;
    return db.query(_tableName);
  }

  @override
  Future<DispositifEntity> insertDispositif(
      final DispositifEntity dispositif) async {
    final db = await database;
    late final DispositifEntity dispositifEntity;
    await db.transaction((txn) async {
      Batch batch = txn.batch();
      final dispositifInsertProperties = {
        for (var property in dispositif.keys.where((k) =>
            k == 'id_dispositif' ||
            k == 'name' ||
            k == 'id_organisme' ||
            k == 'alluvial'))
          property: dispositif[property]
      };
      batch.insert(
        _tableName,
        dispositifInsertProperties,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      await dispositif['placettes']
          .map((placette) async =>
              {await PlacettesDatabaseImpl.insertPlacette(batch, placette)})
          .toList();
      await dispositif['cycles']
          .map((cycle) async =>
              {await CyclesDatabaseImpl.insertCycle(batch, cycle)})
          .toList();

      await batch.commit();

      final results = await txn.query(_tableName,
          where: '$_columnId = ?', whereArgs: [dispositif['id_dispositif']]);
      dispositifEntity = results.first;
    });
    return dispositifEntity;
  }

  @override
  Future<void> updateDispositif(final DispositifEntity dispositif) async {
    final db = await database;
    final int id = dispositif['id'];
    await db.update(
      _tableName,
      dispositif,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> deleteDispositif(final int id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<DispositifListEntity> getUserDispositifs(final int id) async {
    final db = await database;
    return db.query(_tableName);
  }

  @override
  Future<DispositifEntity> getDispositif(final int id) async {
    final db = await database;
    DispositifListEntity dispList = await db.query(_tableName,
        where: '$_columnId = ?', whereArgs: [id], limit: 1);

    final placettesObj = await PlacettesDatabaseImpl.getDispPlacettes(db, id);
    final cycleObj = await CyclesDatabaseImpl.getDispCycles(db, id);
    return {...dispList[0], 'placettes': placettesObj, 'cycles': cycleObj};
  }

  @override
  Future<DispositifEntity> getDispositifAllData(
    final int id,
    String lastSyncTime,
  ) async {
    final db = await database;
    DispositifListEntity dispList = await db.query(_tableName,
        where: '$_columnId = ?', whereArgs: [id], limit: 1);

    final placettesObj = await PlacettesDatabaseImpl.getDispPlacettesAllData(
        db, id, lastSyncTime);
    final cycleObj = await CyclesDatabaseImpl.getDispCycles(db, id);
    return {...dispList[0], 'placettes': placettesObj, 'cycles': cycleObj};
  }

  @override
  Future<void> insertOrUpdateDispositifWithData(SyncResults syncResults) async {
    final db = await database;

    await db.transaction((txn) async {
      Batch batch = txn.batch();

      // Handle placettes
      for (var placette in syncResults.placettes) {
        PlacettesDatabaseImpl.insertPlacette(
            batch, PlacetteMapper.transformToMap(placette));
      }

      // Handle cycles
      for (var cycle in syncResults.cycles) {
        CyclesDatabaseImpl.insertCycle(
            batch, CycleMapper.transformToMap(cycle));
      }

      // Commit all inserts/updates as a single transaction
      await batch.commit(noResult: true);
    });
  }
}
