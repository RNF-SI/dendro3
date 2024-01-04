import 'package:dendro3/data/datasource/implementation/database/arbres_mesures_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/data/datasource/implementation/database/global_database_impl.dart';
import 'package:dendro3/data/datasource/interface/database/arbres_database.dart';
import 'package:dendro3/data/entity/arbresMesures_entity.dart';
import 'package:dendro3/data/entity/arbres_entity.dart';
import 'package:dendro3/domain/model/arbre.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ArbresDatabaseImpl implements ArbresDatabase {
  static const _tableName = 't_arbres';
  static const _columnId = 'id_arbre';

  Future<Database> get database async {
    return await DB.instance.database;
  }
  // @override
  // Future<ArbreListEntity> allArbres() async {
  //   final db = await database;
  //   return db.query(_tableName);
  // }

  // Function called to add an arbre and his arbre mesures
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

  static Future<List<ArbreEntity>> getPlacetteArbres(
      Database db, final int placetteId) async {
    ArbreListEntity arbreList = await db
        .query(_tableName, where: 'id_placette = ?', whereArgs: [placetteId]);

    var arbreMesureObj;

    return Future.wait(arbreList.map((ArbreEntity arbreEntity) async {
      ArbreMesureListEntity arbreMesureObj =
          await ArbresMesuresDatabaseImpl.getArbreArbresMesures(
              db, arbreEntity["id_arbre"]);
      return {...arbreEntity, 'arbres_mesures': arbreMesureObj};
    }).toList());
  }

  @override
  // Function called when one arbre is added (not adding arbre mesure)
  Future<ArbreEntity> addArbre(final ArbreEntity arbre) async {
    final db = await database;
    late final ArbreEntity arbreEntity;
    await db.transaction((txn) async {
      int? maxId = Sqflite.firstIntValue(
              await txn.rawQuery('SELECT MAX(id_arbre) FROM $_tableName')) ??
          0;

      int? maxIdOrig = Sqflite.firstIntValue(await txn.rawQuery(
              'SELECT MAX(id_arbre_orig) FROM $_tableName WHERE id_placette = ?',
              [arbre['id_placette']])) ??
          0;

      arbre['id_arbre'] = maxId + 1;
      arbre['id_arbre_orig'] = maxIdOrig + 1;
      await txn.insert(
        _tableName,
        arbre,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      final results = await txn
          .query(_tableName, where: '$_columnId = ?', whereArgs: [maxId! + 1]);
      arbreEntity = results.first;
    });
    return arbreEntity;
  }

  @override
  // Function called when one arbre is updated (not updating arbre mesure)
  Future<ArbreEntity> updateArbre(final ArbreEntity arbre) async {
    final db = await database;
    late final ArbreEntity arbreEntity;
    await db.transaction((txn) async {
      await txn.update(
        _tableName,
        arbre,
        where: '$_columnId = ?',
        whereArgs: [arbre['id_arbre']],
      );

      final results = await txn.query(_tableName,
          where: '$_columnId = ?', whereArgs: [arbre['id_arbre']]);
      arbreEntity = results.first;
    });
    return arbreEntity;
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

  @override
  Future<void> deleteArbre(final int id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }
}
