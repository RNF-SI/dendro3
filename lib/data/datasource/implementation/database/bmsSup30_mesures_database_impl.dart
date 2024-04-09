import 'package:dendro3/core/helpers/generate_Uuid.dart';
import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/core/helpers/format_DateTime.dart';
import 'package:dendro3/data/datasource/interface/database/bmsSup30_mesures_database.dart';
import 'package:dendro3/data/entity/bmsSup30Mesures_entity.dart';
import 'package:dendro3/data/entity/bmsSup30_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class BmsSup30MesuresDatabaseImpl implements BmsSup30MesuresDatabase {
  static const _tableName = 't_bm_sup_30_mesures';
  static const _columnId = 'id_bm_sup_30_mesure';

  Future<Database> get database async {
    return await DB.instance.database;
  }

  // @override
  // Future<BmSup30ListEntity> allBmsSup30Mesures() async {
  //   final db = await database;
  //   return db.query(_tableName);
  // }

  static Future<void> insertBmSup30Mesure(
      Batch batch, final BmSup30MesureEntity bmSup30Mesure) async {
    batch.insert(_tableName, bmSup30Mesure,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<BmSup30MesureListEntity> getbmSup30bmsSup30Mesures(
      Database db, final String bmsSup30Id) async {
    return await db.query(_tableName,
        where: 'id_bm_sup_30 = ? AND deleted = 0', whereArgs: [bmsSup30Id]);
  }

  static Future<Map<String, BmSup30MesureListEntity>>
      getbmSup30bmsSup30MesuresForDataSync(
          Database db, final String bmsSup30Id, String lastSyncTime) async {
    // Fetch newly created BmSup30Mesure records
    List<BmSup30MesureEntity> createdBmsup30mesure = await db.query(
      _tableName,
      where: 'id_bm_sup_30 = ? AND created_at > ? AND deleted = 0',
      whereArgs: [bmsSup30Id, lastSyncTime],
    );

    // Fetch updated BmSup30Mesure records
    List<BmSup30MesureEntity> updatedBmsup30mesure = await db.query(
      _tableName,
      where:
          'id_bm_sup_30 = ? AND updated_at > ? AND created_at <= ? AND deleted = 0',
      whereArgs: [bmsSup30Id, lastSyncTime, lastSyncTime],
    );

    // Fetch deleted BmSup30Mesure records
    List<BmSup30MesureEntity> deletedBmsup30mesure = await db.query(
      _tableName,
      where: 'id_bm_sup_30 = ? AND deleted = 1 AND updated_at > ?',
      whereArgs: [bmsSup30Id, lastSyncTime],
    );

    return {
      "created": createdBmsup30mesure,
      "updated": updatedBmsup30mesure,
      "deleted": deletedBmsup30mesure,
    };
  }

  @override
  Future<BmSup30MesureEntity> addBmSup30Mesure(
      BmSup30MesureEntity bmSup30Mesure) async {
    final db = await database;
    late final BmSup30Entity bmsup30Entity;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('userName') ?? 'Unknown';
    String terminalName = prefs.getString('terminalName') ?? 'Unknown';

    await db.transaction((txn) async {
      String idBmSup30MesureUUID = generateUuid();
      bmSup30Mesure['id_bm_sup_30_mesure'] = idBmSup30MesureUUID;
      // Par défaut created_at et update_at sont remplies.
      bmSup30Mesure['created_by'] = userName; // Set created_by
      bmSup30Mesure['updated_by'] =
          userName; // Set updated_by on creation as well
      bmSup30Mesure['created_on'] = terminalName;
      bmSup30Mesure['updated_on'] = terminalName;

      await txn.insert(
        _tableName,
        bmSup30Mesure,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      final results = await txn.query(_tableName,
          where: '$_columnId = ?', whereArgs: [idBmSup30MesureUUID]);
      bmsup30Entity = results.first;
    });
    return bmsup30Entity;
  }

  @override
  Future<BmSup30MesureEntity> updateBmSup30Mesure(
    final BmSup30MesureEntity bmSup30Mesure,
  ) async {
    final db = await database;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('userName') ?? 'Unknown';
    String terminalName = prefs.getString('terminalName') ?? 'Unknown';

    late final BmSup30MesureEntity bmSup30MesureEntity;
    await db.transaction((txn) async {
      var updatedBmSup30Mesure = Map<String, dynamic>.from(bmSup30Mesure)
        ..['updated_at'] =
            formatDateTime(DateTime.now()) // Add current timestamp
        ..['updated_by'] = userName
        ..['updated_on'] = terminalName;
      await txn.update(
        _tableName,
        updatedBmSup30Mesure,
        where: '$_columnId = ?',
        whereArgs: [bmSup30Mesure['id_bm_sup_30_mesure']],
      );

      final results = await txn.query(_tableName,
          where: '$_columnId = ?',
          whereArgs: [bmSup30Mesure['id_bm_sup_30_mesure']]);
      bmSup30MesureEntity = results.first;
    });
    return bmSup30MesureEntity;
  }
  // @override
  // Future<void> updateBmSup30(final BmSup30Entity bmSup30) async {
  //   final db = await database;
  //   final int id = bmSup30['id'];
  //   await db.update(
  //     _tableName,
  //     bmSup30,
  //     where: '$_columnId = ?',
  //     whereArgs: [id],
  //   );
  // }

  @override
  Future<void> deleteBmSup30MesureFromIdBmSup30(final String id) async {
    final db = await database;
    await db.update(
      _tableName,
      {'deleted': 1},
      where: 'id_bm_sup_30 = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> deleteBmSup30Mesure(final String id) async {
    final db = await database;
    await db.update(
      _tableName,
      {'deleted': 1},
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }
}
