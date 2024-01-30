import 'package:dendro3/core/helpers/generate_Uuid.dart';
import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/core/helpers/format_DateTime.dart';
import 'package:dendro3/data/datasource/interface/database/regenerations_database.dart';
import 'package:dendro3/data/entity/regenerations_entity.dart';
import 'package:sqflite/sqflite.dart';

class RegenerationsDatabaseImpl implements RegenerationsDatabase {
  static const _tableName = 't_regenerations';
  static const _columnId = 'id_regeneration';

  Future<Database> get database async {
    return await DB.instance.database;
  }

  // @override
  // Future<RegenerationListEntity> allRegenerations() async {
  //   final db = await database;
  //   return db.query(_tableName);
  // }

  static Future<void> insertRegeneration(
      Batch batch, final RegenerationEntity regeneration) async {
    batch.insert(_tableName, regeneration,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static getCorCyclePlacetteRegenerations(
      Database db, final String corCyclePlacetteId) async {
    return await db.query(_tableName,
        where: 'id_cycle_placette = ? AND deleted = 0',
        whereArgs: [corCyclePlacetteId]);
  }

  static Future<Map<String, List<RegenerationEntity>>>
      getCorCyclePlacetteRegenerationsForDataSync(Database db,
          final String corCyclePlacetteId, String lastSyncTime) async {
    var createdRegenerations = await db.query(
      _tableName,
      where: 'id_cycle_placette = ? AND creation_date > ? AND deleted = 0',
      whereArgs: [corCyclePlacetteId, lastSyncTime],
    );

    var updatedRegenerations = await db.query(
      _tableName,
      where:
          'id_cycle_placette = ? AND last_update > ? AND creation_date <= ? AND deleted = 0',
      whereArgs: [corCyclePlacetteId, lastSyncTime, lastSyncTime],
    );

    var deletedRegenerations = await db.query(
      _tableName,
      where: 'id_cycle_placette = ? AND deleted = 1 AND last_update > ?',
      whereArgs: [corCyclePlacetteId, lastSyncTime],
    );

    return {
      "created": createdRegenerations,
      "updated": updatedRegenerations,
      "deleted": deletedRegenerations,
    };
  }

  @override
  // Function called when one regeneration is added
  Future<RegenerationEntity> addRegeneration(
      final RegenerationEntity regeneration) async {
    final db = await database;
    late final RegenerationEntity regenerationEntity;
    await db.transaction((txn) async {
      String regenerationUuid = generateUuid();

      regeneration['id_regeneration'] = regenerationUuid;
      await txn.insert(
        _tableName,
        regeneration,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      final results = await txn.query(_tableName,
          where: '$_columnId = ?', whereArgs: [regenerationUuid]);
      regenerationEntity = results.first;
    });
    return regenerationEntity;
  }

  @override
  Future<RegenerationEntity> updateRegeneration(
      final RegenerationEntity regeneration) async {
    final db = await database;
    late final RegenerationEntity regenerationEntity;
    await db.transaction((txn) async {
      var updatedRegeneration = Map<String, dynamic>.from(regeneration)
        ..['last_update'] = formatDateTime(DateTime.now());

      await txn.update(
        _tableName,
        updatedRegeneration,
        where: '$_columnId = ?',
        whereArgs: [regeneration['id_regeneration']],
      );

      final results = await txn.query(_tableName,
          where: '$_columnId = ?',
          whereArgs: [regeneration['id_regeneration']]);
      regenerationEntity = results.first;
    });
    return regenerationEntity;
  }

  // @override
  // Future<void> updateRegeneration(final RegenerationEntity regeneration) async {
  //   final db = await database;
  //   final int id = regeneration['id'];
  //   await db.update(
  //     _tableName,
  //     regeneration,
  //     where: '$_columnId = ?',
  //     whereArgs: [id],
  //   );
  // }

  @override
  Future<void> deleteRegeneration(final String id) async {
    final db = await database;
    await db.update(
      _tableName,
      {'deleted': 1}, // Mark the record as deleted
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> deleteRegenerationsForCorCyclePlacette(final String id) async {
    final db = await database;
    await db.update(
      _tableName,
      {'deleted': 1}, // Mark the records as deleted
      where: 'id_cycle_placette = ?',
      whereArgs: [id],
    );
  }
}
