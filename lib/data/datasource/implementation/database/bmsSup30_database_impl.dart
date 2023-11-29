import 'package:dendro3/data/datasource/implementation/database/bmsSup30_mesures_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/data/datasource/implementation/database/global_database_impl.dart';
import 'package:dendro3/data/datasource/interface/database/bmsSup30_database.dart';
import 'package:dendro3/data/datasource/interface/database/bmsSup30_mesures_database.dart';
import 'package:dendro3/data/entity/bmsSup30Mesures_entity.dart';
import 'package:dendro3/data/entity/bmsSup30_entity.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/bmSup30_list.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BmsSup30DatabaseImpl implements BmsSup30Database {
  static const _tableName = 't_bm_sup_30';
  static const _columnId = 'id_bm_sup_30';

  Future<Database> get database async {
    return await DB.instance.database;
  }

  // @override
  // Future<BmSup30MesuresListEntity> allBmsSup30Mesures() async {
  //   final db = await database;
  //   return db.query(_tableName);
  // }

  static Future<void> insertBmSup30(
      Batch batch, final BmSup30Entity bmSup30) async {
    final bmSup30InsertProperties = {
      for (var property in bmSup30.keys.where((k) =>
          k == 'id_bm_sup_30' ||
          k == 'id_bm_sup_30_orig' ||
          k == 'id_placette' ||
          k == 'id_arbre' ||
          k == 'code_essence' ||
          k == 'azimut' ||
          k == 'distance' ||
          k == 'orientation' ||
          k == 'azimut_souche' ||
          k == 'distance_souche' ||
          k == 'observation'))
        property: bmSup30[property]
    };

    batch.insert(_tableName, bmSup30InsertProperties,
        conflictAlgorithm: ConflictAlgorithm.replace);

    bmSup30['bm_sup_30_mesures']
        .map((bmSup30Mesure) async => {
              await BmsSup30MesuresDatabaseImpl.insertBmSup30Mesure(
                  batch, bmSup30Mesure)
            })
        .toList();
  }

  static Future<List<BmSup30Entity>> getPlacetteBmSup30(
      Database db, final int placetteId) async {
    BmSup30ListEntity bmSup30List = await db
        .query(_tableName, where: 'id_placette = ?', whereArgs: [placetteId]);

    var bmSup30MesureObj;
    return Future.wait(bmSup30List.map((BmSup30Entity bmSup30Entity) async {
      bmSup30MesureObj =
          await BmsSup30MesuresDatabaseImpl.getbmSup30bmsSup30Mesures(
              db, bmSup30Entity["id_bm_sup_30"]);
      return {...bmSup30Entity, 'bm_sup_30_mesures': bmSup30MesureObj};
    }).toList());
  }

  @override
  // called when one bms is added
  Future<BmSup30Entity> addBmSup30(BmSup30Entity bmSup30) async {
    final db = await database;
    late final BmSup30Entity bmSup30Entity;
    await db.transaction((txn) async {
      int? maxId = Sqflite.firstIntValue(
          await txn.rawQuery('SELECT MAX(id_bm_sup_30) FROM $_tableName'));

      int? maxIdOrig = Sqflite.firstIntValue(await txn.rawQuery(
          'SELECT MAX(id_bm_sup_30_orig) FROM $_tableName WHERE id_placette = ?',
          [bmSup30['id_placette']]));

      bmSup30['id_bm_sup_30'] = maxId! + 1;
      bmSup30['id_bm_sup_30_orig'] = maxIdOrig! + 1;
      await txn.insert(
        _tableName,
        bmSup30,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      final results = await txn
          .query(_tableName, where: '$_columnId = ?', whereArgs: [maxId! + 1]);
      bmSup30Entity = results.first;
    });
    return bmSup30Entity;
  }

  @override
  Future<BmSup30Entity> updateBmSup30(BmSup30Entity bmSup30) async {
    final db = await database;
    late final BmSup30Entity bmSup30Entity;
    await db.transaction((txn) async {
      await txn.update(
        _tableName,
        bmSup30,
        where: '$_columnId = ?',
        whereArgs: [bmSup30['id_bm_sup_30']],
      );

      final results = await txn.query(_tableName,
          where: '$_columnId = ?', whereArgs: [bmSup30['id_bm_sup_30']]);
      bmSup30Entity = results.first;
    });
    return bmSup30Entity;
  }

  // @override
  // Future<void> updateBmSup30Mesures(final BmSup30MesuresEntity bmSup30) async {
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
  // Future<void> deleteBmSup30Mesures(final int id) async {
  //   final db = await database;
  //   await db.delete(
  //     _tableName,
  //     where: '$_columnId = ?',
  //     whereArgs: [id],
  //   );
  // }

}
