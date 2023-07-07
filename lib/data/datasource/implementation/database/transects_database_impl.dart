import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/data/datasource/implementation/database/global_database_impl.dart';
import 'package:dendro3/data/datasource/interface/database/transects_database.dart';
import 'package:dendro3/data/entity/transects_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TransectsDatabaseImpl implements TransectsDatabase {
  static const _tableName = 't_transects';

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
      Database db, final int corCyclePlacetteId) async {
    return await db.query(_tableName,
        where: 'id_cycle_placette = ?', whereArgs: [corCyclePlacetteId]);
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
