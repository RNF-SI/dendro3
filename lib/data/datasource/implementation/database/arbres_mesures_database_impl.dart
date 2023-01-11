import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/data/datasource/implementation/database/global_database_impl.dart';
import 'package:dendro3/data/datasource/interface/database/arbres_mesures_database.dart';
import 'package:dendro3/data/entity/arbresMesures_entity.dart';
import 'package:dendro3/data/entity/arbres_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ArbresMesuresDatabaseImpl implements ArbresMesuresDatabase {
  static const _tableName = 't_arbres_mesures';

  Future<Database> get database async {
    return await DB.instance.database;
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
