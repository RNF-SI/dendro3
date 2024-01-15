import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/data/datasource/implementation/database/global_database_impl.dart';
import 'package:dendro3/data/datasource/interface/database/regenerations_database.dart';
import 'package:dendro3/data/entity/regenerations_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class RegenerationsDatabaseImpl implements RegenerationsDatabase {
  static const _tableName = 't_regenerations';
  static const _columnId = 'id_regeneration';

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

  static getCorCyclePlacetteRegenerations(
      Database db, final int corCyclePlacetteId) async {
    return await db.query(_tableName,
        where: 'id_cycle_placette = ?', whereArgs: [corCyclePlacetteId]);
  }

  @override
  // Function called when one regeneration is added
  Future<RegenerationEntity> addRegeneration(
      final RegenerationEntity regeneration) async {
    final db = await database;
    late final RegenerationEntity regenerationEntity;
    await db.transaction((txn) async {
      int? maxId = Sqflite.firstIntValue(await txn
              .rawQuery('SELECT MAX(id_regeneration) FROM $_tableName')) ??
          0;

      regeneration['id_regeneration'] = maxId + 1;
      await txn.insert(
        _tableName,
        regeneration,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      final results = await txn
          .query(_tableName, where: '$_columnId = ?', whereArgs: [maxId! + 1]);
      regenerationEntity = results.first;
    });
    return regenerationEntity;
  }

  @override
  Future<RegenerationEntity> updateRegeneration(
      final RegenerationEntity regeneration) async {
    final db = await database;
    late final RegenerationEntity regenerationEntity;
    await db.transaction((txn) async {
      await txn.update(
        _tableName,
        regeneration,
        where: '$_columnId = ?',
        whereArgs: [regeneration['id_regeneration']],
      );

      final results = await txn.query(_tableName,
          where: '$_columnId = ?',
          whereArgs: [regeneration['id_regeneration']]);
      regenerationEntity = results.first;
    });
    return regenerationEntity;
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

  @override
  Future<void> deleteRegeneration(final int id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> deleteRegenerationsForCorCyclePlacette(final int id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id_cycle_placette = ?',
      whereArgs: [id],
    );
  }
}
