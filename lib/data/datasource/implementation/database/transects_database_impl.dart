import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/data/datasource/implementation/database/global_database_impl.dart';
import 'package:dendro3/data/datasource/interface/database/transects_database.dart';
import 'package:dendro3/data/entity/transects_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TransectsDatabaseImpl implements TransectsDatabase {
  static const _tableName = 't_transects';
  static const _columnId = 'id_transects';

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

  @override
  // Function called when one transect is added
  Future<TransectEntity> addTransect(final TransectEntity transect) async {
    final db = await database;
    late final TransectEntity transectEntity;
    await db.transaction((txn) async {
      int? maxId = Sqflite.firstIntValue(
          await txn.rawQuery('SELECT MAX(id_transect) FROM $_tableName'));

      int? maxIdOrig = Sqflite.firstIntValue(await txn.rawQuery(
          'SELECT MAX(id_transect_orig) FROM $_tableName WHERE id_cycle_placette = ?',
          [transect['id_cycle_placette']]));

      transect['id_transect'] = maxId! + 1;
      transect['id_transect_orig'] = maxIdOrig! + 1;

      await txn.insert(
        _tableName,
        transect,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      final results = await txn
          .query(_tableName, where: '$_columnId = ?', whereArgs: [maxId! + 1]);
      transectEntity = results.first;
    });
    return transectEntity;
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
