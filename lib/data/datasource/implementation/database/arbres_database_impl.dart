import 'package:dendro3/data/datasource/implementation/database/arbres_mesures_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/data/datasource/implementation/database/global_database_impl.dart';
import 'package:dendro3/data/datasource/interface/database/arbres_database.dart';
import 'package:dendro3/data/entity/arbres_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ArbresDatabaseImpl implements ArbresDatabase {
  static const _tableName = 't_arbres';

  Future<Database> get database async {
    return await DB.instance.database;
  }
  // @override
  // Future<ArbreListEntity> allArbres() async {
  //   final db = await database;
  //   return db.query(_tableName);
  // }

  static Future<void> insertArbre(Batch batch, final ArbreEntity arbre) async {
    final arbreInsertProperties = {
      for (var property in arbre.keys.where((k) =>
          k == 'id_arbre' ||
          k == 'id_arbre_orig' ||
          k == 'id_placette' ||
          k == 'code_essence' ||
          k == 'azimut' ||
          k == 'distance' ||
          k == 'taillis' ||
          k == 'observation'))
        property: arbre[property]
    };

    batch.insert(_tableName, arbreInsertProperties,
        conflictAlgorithm: ConflictAlgorithm.replace);

    arbre['arbres_mesures']
        .map((arbreMesure) async => {
              await ArbresMesuresDatabaseImpl.insertArbreMesure(
                  batch, arbreMesure)
            })
        .toList();
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
