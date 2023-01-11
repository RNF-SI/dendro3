import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/data/datasource/implementation/database/global_database_impl.dart';
import 'package:dendro3/data/datasource/interface/database/bmsSup30_mesures_database.dart';
import 'package:dendro3/data/entity/bmsSup30Mesures_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BmsSup30MesuresDatabaseImpl implements BmsSup30MesuresDatabase {
  static const _tableName = 't_bm_sup_30_mesures';

  Future<Database> get database async {
    return await DB.instance.database;
  }

  // @override
  // Future<BmSup30ListEntity> allBmsSup30Mesures() async {
  //   final db = await database;
  //   return db.query(_tableName);
  // }

  static Future<void> insertBmSup30Mesure(
      Batch batch, final BmSup30MesureEntity bmSup30Mesure) async {
    batch.insert(_tableName, bmSup30Mesure,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<BmSup30MesureListEntity> getbmSup30bmsSup30Mesures(
      Database db, final int bmsSup30Id) async {
    return await db
        .query(_tableName, where: 'id_bm_sup_30 = ?', whereArgs: [bmsSup30Id]);
  }

  // @override
  // Future<void> updateBmSup30(final BmSup30Entity bmSup30) async {
  //   final db = await database;
  //   final int id = bmSup30['id'];
  //   await db.update(
  //     _tableName,
  //     bmSup30,
  //     where: '$_columnId = ?',
  //     whereArgs: [id],
  //   );
  // }

  // @override
  // Future<void> deleteBmSup30(final int id) async {
  //   final db = await database;
  //   await db.delete(
  //     _tableName,
  //     where: '$_columnId = ?',
  //     whereArgs: [id],
  //   );
  // }

}
