import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/data/datasource/implementation/database/global_database_impl.dart';
import 'package:dendro3/data/datasource/interface/database/reperes_database.dart';
import 'package:dendro3/data/entity/reperes_entity.dart';
import 'package:path/path.dart';
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
    return await db
        .query(_tableName, where: 'id_placette = ?', whereArgs: [placetteId]);
  }

  @override
  // Function called when one repere is added
  Future<RepereEntity> addRepere(final RepereEntity repere) async {
    final db = await database;
    late final RepereEntity repereEntity;
    await db.transaction((txn) async {
      int? maxId = Sqflite.firstIntValue(
              await txn.rawQuery('SELECT MAX(id_repere) FROM $_tableName')) ??
          0;

      repere['id_repere'] = maxId! + 1;
      await txn.insert(
        _tableName,
        repere,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      final results = await txn
          .query(_tableName, where: '$_columnId = ?', whereArgs: [maxId! + 1]);
      repereEntity = results.first;
    });
    return repereEntity;
  }

  @override
  // Function called when one arbre is updated (not updating arbre mesure)
  Future<RepereEntity> updateRepere(final RepereEntity repere) async {
    final db = await database;
    late final RepereEntity transectEntity;
    await db.transaction((txn) async {
      await txn.update(
        _tableName,
        repere,
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
  Future<void> deleteRepere(final int id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }
}
