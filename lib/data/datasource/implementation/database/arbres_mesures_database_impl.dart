import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/data/datasource/implementation/database/global_database_impl.dart';
import 'package:dendro3/data/datasource/interface/database/arbres_mesures_database.dart';
import 'package:dendro3/data/entity/arbresMesures_entity.dart';
import 'package:dendro3/data/entity/arbres_entity.dart';
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

  // @override
  // Future<ArbreListEntity> allArbresMesures() async {
  //   final db = await database;
  //   return db.query(_tableName);
  // }

  static Future<void> insertArbreMesure(
      Batch batch, final ArbreMesureEntity arbreMesure) async {
    batch.insert(_tableName, arbreMesure,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<ArbreMesureListEntity> getArbreArbresMesures(
      Database db, final int arbreId) async {
    return await db
        .query(_tableName, where: 'id_arbre = ?', whereArgs: [arbreId]);
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
