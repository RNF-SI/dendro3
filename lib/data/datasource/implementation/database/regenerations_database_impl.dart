import 'package:dendro3/core/helpers/generate_Uuid.dart';
import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/core/helpers/format_DateTime.dart';
import 'package:dendro3/data/datasource/interface/database/regenerations_database.dart';
import 'package:dendro3/data/entity/regenerations_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      getCorCyclePlacetteRegenerationsForDataSync(Transaction txn,
          final String corCyclePlacetteId, String lastSyncTime) async {
    var createdRegenerations = await txn.query(
      _tableName,
      where: 'id_cycle_placette = ? AND created_at > ? AND deleted = 0',
      whereArgs: [corCyclePlacetteId, lastSyncTime],
    );

    var updatedRegenerations = await txn.query(
      _tableName,
      where:
          'id_cycle_placette = ? AND updated_at > ? AND created_at <= ? AND deleted = 0',
      whereArgs: [corCyclePlacetteId, lastSyncTime, lastSyncTime],
    );

    var deletedRegenerations = await txn.query(
      _tableName,
      where: 'id_cycle_placette = ? AND deleted = 1 AND updated_at > ?',
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('userName') ?? 'Unknown';
    String terminalName = prefs.getString('terminalName') ?? 'Unknown';
    String formattedDate = formatDateTime(DateTime.now());

    await db.transaction((txn) async {
      String regenerationUuid = generateUuid();

      regeneration['id_regeneration'] = regenerationUuid;
      // Par défaut created_at et update_at sont remplies.
      regeneration['created_by'] = userName; // Set created_by
      regeneration['updated_by'] =
          userName; // Set updated_by on creation as well
      regeneration['created_on'] = terminalName;
      regeneration['updated_on'] = terminalName;
      regeneration['created_at'] = formattedDate;
      regeneration['updated_at'] = formattedDate;
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('userName') ?? 'Unknown';
    String terminalName = prefs.getString('terminalName') ?? 'Unknown';

    late final RegenerationEntity regenerationEntity;
    await db.transaction((txn) async {
      var updatedRegeneration = Map<String, dynamic>.from(regeneration)
        ..['updated_at'] = formatDateTime(DateTime.now())
        ..['updated_by'] = userName
        ..['updated_on'] = terminalName;

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
