import 'package:dendro3/core/helpers/generate_Uuid.dart';
import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/core/helpers/format_DateTime.dart';
import 'package:dendro3/data/datasource/interface/database/transects_database.dart';
import 'package:dendro3/data/entity/transects_entity.dart';
import 'package:sqflite/sqflite.dart';

class TransectsDatabaseImpl implements TransectsDatabase {
  static const _tableName = 't_transects';
  static const _columnId = 'id_transect';

  Future<Database> get database async {
    return await DB.instance.database;
  }
  // @override
  // Future<TransectListEntity> allTransects() async {
  //   final db = await database;
  //   return db.query(_tableName);
  // }

  static Future<void> insertTransect(
      Batch batch, final TransectEntity transect) async {
    batch.insert(_tableName, transect,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static getCorCyclePlacetteTransects(
      Database db, final String corCyclePlacetteId) async {
    return await db.query(_tableName,
        where: 'id_cycle_placette = ? AND deleted = 0',
        whereArgs: [corCyclePlacetteId]);
  }

  static Future<Map<String, List<TransectEntity>>>
      getCorCyclePlacetteTransectsForDataSync(Database db,
          final String corCyclePlacetteId, String lastSyncTime) async {
    var createdTransects = await db.query(
      _tableName,
      where: 'id_cycle_placette = ? AND creation_date > ? AND deleted = 0',
      whereArgs: [corCyclePlacetteId, lastSyncTime],
    );

    var updatedTransects = await db.query(
      _tableName,
      where:
          'id_cycle_placette = ? AND last_update > ? AND creation_date <= ? AND deleted = 0',
      whereArgs: [corCyclePlacetteId, lastSyncTime, lastSyncTime],
    );

    var deletedTransects = await db.query(
      _tableName,
      where: 'id_cycle_placette = ? AND deleted = 1 AND last_update > ?',
      whereArgs: [corCyclePlacetteId, lastSyncTime],
    );

    return {
      "created": createdTransects,
      "updated": updatedTransects,
      "deleted": deletedTransects,
    };
  }

  @override
  // Function called when one transect is added
  Future<TransectEntity> addTransect(final TransectEntity transect) async {
    final db = await database;
    late final TransectEntity transectEntity;
    await db.transaction((txn) async {
      String transectUuid = generateUuid();
      transect['id_transect'] = transectUuid;

      int? maxIdOrig = Sqflite.firstIntValue(await txn.rawQuery(
              'SELECT MAX(id_transect_orig) FROM $_tableName WHERE id_cycle_placette = ?',
              [transect['id_cycle_placette']])) ??
          0;
      transect['id_transect_orig'] = maxIdOrig + 1;

      await txn.insert(
        _tableName,
        transect,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      final results = await txn.query(_tableName,
          where: '$_columnId = ?', whereArgs: [transectUuid]);
      transectEntity = results.first;
    });
    return transectEntity;
  }

  @override
  // Function called when one arbre is updated (not updating arbre mesure)
  Future<TransectEntity> updateTransect(final TransectEntity transect) async {
    final db = await database;
    late final TransectEntity transectEntity;
    await db.transaction((txn) async {
      var updatedTransect = Map<String, dynamic>.from(transect)
        ..['last_update'] = formatDateTime(DateTime.now());

      await txn.update(
        _tableName,
        updatedTransect,
        where: '$_columnId = ?',
        whereArgs: [transect['id_transect']],
      );

      final results = await txn.query(_tableName,
          where: '$_columnId = ?', whereArgs: [transect['id_transect']]);
      transectEntity = results.first;
    });
    return transectEntity;
  }

  @override
  Future<void> deleteTransect(String id) async {
    final db = await database;
    await db.update(
      _tableName,
      {'deleted': 1},
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> deleteTransectsForCorCyclePlacette(String id) async {
    final db = await database;
    await db.update(
      _tableName,
      {'deleted': 1},
      where: 'id_cycle_placette = ?',
      whereArgs: [id],
    );
  }
  // @override
  // Future<void> updateTransect(final TransectEntity transect) async {
  //   final db = await database;
  //   final int id = transect['id'];
  //   await db.update(
  //     _tableName,
  //     transect,
  //     where: '$_columnId = ?',
  //     whereArgs: [id],
  //   );
  // }

  // @override
  // Future<void> deleteTransect(final int id) async {
  //   final db = await database;
  //   await db.delete(
  //     _tableName,
  //     where: '$_columnId = ?',
  //     whereArgs: [id],
  //   );
  // }
}
