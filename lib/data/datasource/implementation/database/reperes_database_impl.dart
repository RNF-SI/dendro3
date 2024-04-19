import 'package:dendro3/core/helpers/generate_Uuid.dart';
import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/core/helpers/format_DateTime.dart';
import 'package:dendro3/data/datasource/interface/database/reperes_database.dart';
import 'package:dendro3/data/entity/reperes_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class ReperesDatabaseImpl implements ReperesDatabase {
  static const _tableName = 't_reperes';
  static const _columnId = 'id_repere';

  Future<Database> get database async {
    return await DB.instance.database;
  }
  // @override
  // Future<RepereListEntity> allReperes() async {
  //   final db = await database;
  //   return db.query(_tableName);
  // }

  static Future<void> insertRepere(
      Batch batch, final RepereEntity repere) async {
    batch.insert(_tableName, repere,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<RepereEntity>> getPlacetteReperes(
      Database db, int placetteId) async {
    return await db.query(_tableName,
        where: 'id_placette = ? AND deleted = 0', whereArgs: [placetteId]);
  }

  static Future<Map<String, List<RepereEntity>>> getPlacetteReperesForDataSync(
      Transaction txn, int placetteId, String lastSyncTime) async {
    // Fetch newly created Repere records
    List<RepereEntity> createdReperes = await txn.query(
      _tableName,
      where: 'id_placette = ? AND created_at > ? AND deleted = 0',
      whereArgs: [placetteId, lastSyncTime],
    );

    // Fetch updated Repere records
    List<RepereEntity> updatedReperes = await txn.query(
      _tableName,
      where:
          'id_placette = ? AND updated_at > ? AND created_at <= ? AND deleted = 0',
      whereArgs: [placetteId, lastSyncTime, lastSyncTime],
    );

    // Fetch deleted Repere records
    List<RepereEntity> deletedReperes = await txn.query(
      _tableName,
      where: 'id_placette = ? AND deleted = 1 AND updated_at > ?',
      whereArgs: [placetteId, lastSyncTime],
    );

    return {
      "created": createdReperes,
      "updated": updatedReperes,
      "deleted": deletedReperes,
    };
  }

  @override
  // Function called when one repere is added
  Future<RepereEntity> addRepere(final RepereEntity repere) async {
    final db = await database;
    late final RepereEntity repereEntity;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('userName') ?? 'Unknown';
    String terminalName = prefs.getString('terminalName') ?? 'Unknown';
    String formattedDate = formatDateTime(DateTime.now());

    await db.transaction((txn) async {
      String repereUuid = generateUuid();

      repere['id_repere'] = repereUuid;
      // Par défaut created_at et update_at sont remplies.
      repere['created_by'] = userName; // Set created_by
      repere['updated_by'] = userName; // Set updated_by on creation as well
      repere['created_on'] = terminalName;
      repere['updated_on'] = terminalName;
      repere['created_at'] = formattedDate;
      repere['updated_at'] = formattedDate;

      await txn.insert(
        _tableName,
        repere,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      final results = await txn
          .query(_tableName, where: '$_columnId = ?', whereArgs: [repereUuid]);
      repereEntity = results.first;
    });
    return repereEntity;
  }

  @override
  // Function called when one arbre is updated (not updating arbre mesure)
  Future<RepereEntity> updateRepere(final RepereEntity repere) async {
    final db = await database;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('userName') ?? 'Unknown';
    String terminalName = prefs.getString('terminalName') ?? 'Unknown';

    late final RepereEntity transectEntity;
    await db.transaction((txn) async {
      var updatedRepere = Map<String, dynamic>.from(repere)
        ..['updated_at'] = formatDateTime(DateTime.now())
        ..['updated_by'] = userName
        ..['updated_on'] = terminalName;

      await txn.update(
        _tableName,
        updatedRepere,
        where: '$_columnId = ?',
        whereArgs: [repere['id_repere']],
      );

      final results = await txn.query(_tableName,
          where: '$_columnId = ?', whereArgs: [repere['id_repere']]);
      transectEntity = results.first;
    });
    return transectEntity;
  }
  // @override
  // Future<void> updateRepere(final RepereEntity repere) async {
  //   final db = await database;
  //   final int id = repere['id'];
  //   await db.update(
  //     _tableName,
  //     repere,
  //     where: '$_columnId = ?',
  //     whereArgs: [id],
  //   );
  // }

  @override
  Future<void> deleteRepere(final String id) async {
    final db = await database;
    await db.update(
      _tableName,
      {'deleted': 1},
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> deleteRepereFromPlacetteId(final int placetteId) async {
    final db = await database;
    await db.update(
      _tableName,
      {'deleted': 1},
      where: 'id_placette = ?',
      whereArgs: [placetteId],
    );
  }
}
