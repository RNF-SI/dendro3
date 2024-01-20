import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/core/helpers/format_DateTime.dart';
import 'package:dendro3/data/datasource/implementation/database/global_database_impl.dart';
import 'package:dendro3/data/datasource/interface/database/arbres_mesures_database.dart';
import 'package:dendro3/data/datasource/interface/database/cycles_database.dart';
import 'package:dendro3/data/datasource/implementation/database/cycles_database_impl.dart';
import 'package:dendro3/data/entity/arbresMesures_entity.dart';
import 'package:dendro3/data/entity/arbres_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
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
    await db.transaction((txn) async {
      int? maxId = Sqflite.firstIntValue(
          await txn.rawQuery('SELECT MAX(id_arbre_mesure) FROM $_tableName'));

      arbreMesure['id_arbre_mesure'] = maxId! + 1;
      await txn.insert(
        _tableName,
        arbreMesure,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      final results = await txn
          .query(_tableName, where: '$_columnId = ?', whereArgs: [maxId! + 1]);
      arbreEntity = results.first;
    });
    return arbreEntity;
  }

  @override
  Future<ArbreMesureEntity> updateArbreMesure(
      final ArbreMesureEntity arbreMesure) async {
    final db = await database;
    late final ArbreMesureEntity arbreMesureEntity;

    await db.transaction((txn) async {
      // Create a copy of the arbreMesure map and add/modify the last_update field
      var updatedArbreMesure = Map<String, dynamic>.from(arbreMesure)
        ..['last_update'] =
            formatDateTime(DateTime.now()); // Add current timestamp

      await txn.update(
        _tableName,
        updatedArbreMesure, // Use the updated map with the new last_update value
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
      Database db, final int arbreId) async {
    return await db.query(
      _tableName,
      where: 'id_arbre = ? AND deleted = 0', // Exclude deleted records
      whereArgs: [arbreId],
    );
  }

  static Future<Map<String, List<ArbreMesureEntity>>>
      getArbreArbresMesuresForDataSync(
          Database db, final int arbreId, String lastSyncTime) async {
    // Fetch newly created arbreMesures
    List<ArbreMesureEntity> created_arbreMesures = await db.query(
      _tableName,
      where: 'id_arbre = ? AND creation_date > ? AND deleted = 0',
      whereArgs: [arbreId, lastSyncTime],
    );

    // Fetch updated arbreMesures
    List<ArbreMesureEntity> updated_arbreMesures = await db.query(
      _tableName,
      where:
          'id_arbre = ? AND last_update > ? AND creation_date <= ? AND deleted = 0',
      whereArgs: [arbreId, lastSyncTime, lastSyncTime],
    );

    // Fetch deleted arbreMesures
    List<ArbreMesureEntity> deleted_arbreMesures = await db.query(
      _tableName,
      where: 'id_arbre = ? AND deleted = 1 AND last_update > ?',
      whereArgs: [arbreId, lastSyncTime],
    );

    return {
      "created": created_arbreMesures,
      "updated": updated_arbreMesures,
      "deleted": deleted_arbreMesures,
    };
  }

  @override
  Future<ArbreMesureEntity> getPreviousCycleMeasure(
      final int idArbre, final int? idCycle, int? numCycle) async {
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
  Future<ArbreMesureEntity> updateLastArbreMesureCoupe(
      final int idArbreMesure, final String? coupe) async {
    final db = await database;
    late final ArbreMesureEntity arbreMesureEntity;

    await db.transaction((txn) async {
      var updateData = {
        'coupe': coupe,
        'last_update': formatDateTime(DateTime.now())
      };

      await txn.update(
        _tableName,
        updateData,
        where: '$_columnId = ?',
        whereArgs: [idArbreMesure],
      );

      final results = await txn.query(_tableName,
          where: '$_columnId = ?', whereArgs: [idArbreMesure]);
      arbreMesureEntity = results.first;
    });

    return arbreMesureEntity;
  }

  @override
  Future<void> deleteArbreMesureFromIdArbre(final int idArbre) async {
    final db = await database;
    await db.update(
      _tableName,
      {'deleted': 1}, // Mark the record as deleted
      where: 'id_arbre = ?',
      whereArgs: [idArbre],
    );
  }

  @override
  Future<void> deleteArbreMesure(final int idArbreMesure) async {
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
