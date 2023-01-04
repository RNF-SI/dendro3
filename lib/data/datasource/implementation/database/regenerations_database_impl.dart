import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/data/datasource/implementation/database/global_database_impl.dart';
import 'package:dendro3/data/datasource/interface/database/regenerations_database.dart';
import 'package:dendro3/data/entity/regenerations_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class RegenerationsDatabaseImpl implements RegenerationsDatabase {
  static const _tableName = 't_regenerations';

  Future<Database> get database async {
    return await DB.instance.database;
  }

  // @override
  // Future<RegenerationListEntity> allRegenerations() async {
  //   final db = await database;
  //   return db.query(_tableName);
  // }

  static Future<void> insertRegeneration(
      Batch batch, final RegenerationEntity regeneration) async {
    batch.insert(_tableName, regeneration,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // @override
  // Future<void> updateRegeneration(final RegenerationEntity regeneration) async {
  //   final db = await database;
  //   final int id = regeneration['id'];
  //   await db.update(
  //     _tableName,
  //     regeneration,
  //     where: '$_columnId = ?',
  //     whereArgs: [id],
  //   );
  // }

  // @override
  // Future<void> deleteRegeneration(final int id) async {
  //   final db = await database;
  //   await db.delete(
  //     _tableName,
  //     where: '$_columnId = ?',
  //     whereArgs: [id],
  //   );
  // }

}
