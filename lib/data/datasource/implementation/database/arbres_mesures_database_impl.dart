import 'package:dendro3/core/helpers/generate_Uuid.dart';
import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/core/helpers/format_DateTime.dart';
import 'package:dendro3/data/datasource/interface/database/arbres_mesures_database.dart';
import 'package:dendro3/data/datasource/implementation/database/cycles_database_impl.dart';
import 'package:dendro3/data/entity/arbresMesures_entity.dart';
import 'package:dendro3/data/entity/arbres_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class ArbresMesuresDatabaseImpl implements ArbresMesuresDatabase {
  static const _tableName = 't_arbres_mesures';
  static const _columnId = 'id_arbre_mesure';

  Future<Database> get database async {
    return await DB.instance.database;
  }

  @override
  Future<ArbreMesureEntity> addArbreMesure(
      final ArbreMesureEntity arbreMesure) async {
    final db = await database;
    late final ArbreEntity arbreEntity;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('userName') ?? 'Unknown';
    String terminalName = prefs.getString('terminalName') ?? 'Unknown';
    String formattedDate = formatDateTime(DateTime.now());

    await db.transaction((txn) async {
      String idArbreMesureUuid = generateUuid();
      arbreMesure['id_arbre_mesure'] = idArbreMesureUuid;
      // Par défaut created_at et update_at sont remplies
      arbreMesure['created_by'] = userName;
      arbreMesure['updated_by'] = userName;
      arbreMesure['created_on'] = terminalName;
      arbreMesure['updated_on'] = terminalName;
      arbreMesure['created_at'] = formattedDate;
      arbreMesure['updated_at'] = formattedDate;

      await txn.insert(
        _tableName,
        arbreMesure,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      final results = await txn.query(_tableName,
          where: '$_columnId = ?', whereArgs: [idArbreMesureUuid]);
      arbreEntity = results.first;
    });
    return arbreEntity;
  }

  @override
  Future<ArbreMesureEntity> updateArbreMesure(
      final ArbreMesureEntity arbreMesure) async {
    final db = await database;
    late final ArbreMesureEntity arbreMesureEntity;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('userName') ?? 'Unknown';
    String terminalName = prefs.getString('terminalName') ?? 'Unknown';

    await db.transaction((txn) async {
      // Create a copy of the arbreMesure map and add/modify the updated_at field
      var updatedArbreMesure = Map<String, dynamic>.from(arbreMesure)
        ..['updated_at'] =
            formatDateTime(DateTime.now()) // Add current timestamp
        ..['updated_by'] = userName
        ..['updated_on'] = terminalName;

      await txn.update(
        _tableName,
        updatedArbreMesure, // Use the updated map with the new updated_at value
        where: '$_columnId = ?',
        whereArgs: [arbreMesure['id_arbre_mesure']],
      );

      final results = await txn.query(_tableName,
          where: '$_columnId = ?', whereArgs: [arbreMesure['id_arbre_mesure']]);
      arbreMesureEntity = results.first;
    });
    return arbreMesureEntity;
  }

  static Future<void> insertArbreMesure(
      Batch batch, final ArbreMesureEntity arbreMesure) async {
    batch.insert(_tableName, arbreMesure,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<ArbreMesureListEntity> getArbreArbresMesures(
      Database db, final String arbreId) async {
    return await db.query(
      _tableName,
      where: 'id_arbre = ? AND deleted = 0', // Exclude deleted records
      whereArgs: [arbreId],
    );
  }

  static Future<Map<String, List<ArbreMesureEntity>>>
      getArbreArbresMesuresForDataSync(
          Transaction txn, final String arbreId, String lastSyncTime) async {
    // Fetch newly created arbreMesures
    List<ArbreMesureEntity> createdArbremesures = await txn.query(
      _tableName,
      where: 'id_arbre = ? AND created_at > ? AND deleted = 0',
      whereArgs: [arbreId, lastSyncTime],
    );

    // Fetch updated arbreMesures
    List<ArbreMesureEntity> updatedArbremesures = await txn.query(
      _tableName,
      where:
          'id_arbre = ? AND updated_at > ? AND created_at <= ? AND deleted = 0',
      whereArgs: [arbreId, lastSyncTime, lastSyncTime],
    );

    // Fetch deleted arbreMesures
    List<ArbreMesureEntity> deletedArbremesures = await txn.query(
      _tableName,
      where: 'id_arbre = ? AND deleted = 1 AND updated_at > ?',
      whereArgs: [arbreId, lastSyncTime],
    );

    return {
      "created": createdArbremesures,
      "updated": updatedArbremesures,
      "deleted": deletedArbremesures,
    };
  }

  @override
  Future<ArbreMesureEntity> getPreviousCycleMeasure(
      final String idArbre, final int? idCycle, int? numCycle) async {
    final db = await database;

    if (idCycle == null) {
      throw ArgumentError('idCycle cannot be null');
    }

    final cycle = await CyclesDatabaseImpl.getCycle(db, idCycle);
    final lastCycle = await CyclesDatabaseImpl.getCycleFromDispAndNumCycle(
        db, cycle['id_dispositif'], cycle['num_cycle'] - 1);
    ArbreMesureListEntity arbreMesureList = await db.query(
      _tableName,
      where: 'id_cycle = ? AND id_arbre = ? AND deleted = 0',
      whereArgs: [lastCycle['id_cycle'], idArbre],
      limit: 1,
    );
    return arbreMesureList[0];
  }

  @override
  Future<void> deleteArbreMesureFromIdArbre(final String idArbre) async {
    final db = await database;
    await db.update(
      _tableName,
      {'deleted': 1}, // Mark the record as deleted
      where: 'id_arbre = ?',
      whereArgs: [idArbre],
    );
  }

  @override
  Future<void> deleteArbreMesure(final String idArbreMesure) async {
    final db = await database;
    await db.update(
      _tableName,
      {'deleted': 1}, // Mark the record as deleted
      where: '$_columnId = ?',
      whereArgs: [idArbreMesure],
    );
  }

  // @override
  // Future<void> updateArbre(final ArbreEntity arbre) async {
  //   final db = await database;
  //   final int id = arbre['id'];
  //   await db.update(
  //     _tableName,
  //     arbre,
  //     where: '$_columnId = ?',
  //     whereArgs: [id],
  //   );
  // }

  // @override
  // Future<void> deleteArbre(final int id) async {
  //   final db = await database;
  //   await db.delete(
  //     _tableName,
  //     where: '$_columnId = ?',
  //     whereArgs: [id],
  //   );
  // }
}
