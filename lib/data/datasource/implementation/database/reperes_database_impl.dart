import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/data/datasource/implementation/database/global_database_impl.dart';
import 'package:dendro3/data/datasource/interface/database/reperes_database.dart';
import 'package:dendro3/data/entity/reperes_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ReperesDatabaseImpl implements ReperesDatabase {
  static const _tableName = 't_reperes';

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
    return await db
        .query(_tableName, where: 'id_placette = ?', whereArgs: [placetteId]);
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

  // @override
  // Future<void> deleteRepere(final int id) async {
  //   final db = await database;
  //   await db.delete(
  //     _tableName,
  //     where: '$_columnId = ?',
  //     whereArgs: [id],
  //   );
  // }

}
