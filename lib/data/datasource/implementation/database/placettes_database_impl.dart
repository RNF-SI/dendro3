import 'package:dendro3/data/datasource/implementation/database/arbres_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/bmsSup30_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/corCyclesPlacettes_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/data/datasource/implementation/database/reperes_database_impl.dart';
import 'package:dendro3/data/datasource/interface/database/placettes_database.dart';
import 'package:dendro3/data/entity/arbres_entity.dart';
import 'package:dendro3/data/entity/bmsSup30_entity.dart';
import 'package:dendro3/data/entity/corCyclesPlacettes_entity.dart';
import 'package:dendro3/data/entity/placettes_entity.dart';
import 'package:dendro3/data/entity/reperes_entity.dart';
import 'package:sqflite/sqflite.dart';

class PlacettesDatabaseImpl implements PlacettesDatabase {
  static const _tableName = 't_placettes';
  static const _columnId = 'id_placette';

  Future<Database> get database async {
    return await DB.instance.database;
  }
  // @override
  // Future<PlacetteListEntity> allPlacettes() async {
  //   final db = await database;
  //   return db.query(_tableName);
  // }

  static Future<void> insertPlacette(
      Batch batch, final PlacetteEntity placette) async {
    final placetteInsertProperties = {
      for (var property in placette.keys.where((k) =>
          k == 'id_placette' ||
          k == 'id_dispositif' ||
          k == 'id_placette_orig' ||
          k == 'strate' ||
          k == 'pente' ||
          k == 'poids_placette' ||
          k == 'correction_pente' ||
          k == 'exposition' ||
          k == 'profondeur_app' ||
          k == 'profondeur_hydr' ||
          k == 'texture' ||
          k == 'habitat' ||
          k == 'station' ||
          k == 'typologie' ||
          k == 'groupe' ||
          k == 'groupe1' ||
          k == 'groupe2' ||
          k == 'ref_habitat' ||
          k == 'precision_habitat' ||
          k == 'ref_station' ||
          k == 'ref_typologie' ||
          k == 'descriptif_groupe' ||
          k == 'descriptif_groupe1' ||
          k == 'descriptif_groupe2' ||
          k == 'precision_gps' ||
          k == 'cheminement'))
        property: placette[property]
    };

    batch.insert(_tableName, placetteInsertProperties,
        conflictAlgorithm: ConflictAlgorithm.replace);

    await placette['arbres']
        .map((arbre) async =>
            {await ArbresDatabaseImpl.insertArbre(batch, arbre)})
        .toList();
    await placette['bmsSup30']
        .map((bmSup30) async =>
            {await BmsSup30DatabaseImpl.insertBmSup30(batch, bmSup30)})
        .toList();
    await placette['reperes']
        .map((repere) async =>
            {await ReperesDatabaseImpl.insertRepere(batch, repere)})
        .toList();
  }

  static Future<PlacetteListEntity> getDispPlacettes(
      Database db, final int dispositifId) async {
    PlacetteListEntity placetteList = await db.query(_tableName,
        where: 'id_dispositif = ?', whereArgs: [dispositifId]);
    List<PlacetteListEntity> placetteObj;
    return Future.wait(placetteList.map((PlacetteEntity placetteEntity) async {
      CorCyclePlacetteListEntity corCyclesPlacettesObj =
          await CorCyclesPlacettesDatabaseImpl.getPlacetteCorCyclesPlacettes(
              db, placetteEntity['id_placette']);
      return {...placetteEntity, 'corCyclesPlacettes': corCyclesPlacettesObj};
    }).toList());
  }

  static Future<PlacetteListEntity> getDispPlacettesAllData(
      Database db, final int dispositifId, String lastSyncTime) async {
    return db.transaction((txn) async {
      List<Map<String, dynamic>> placetteList = await txn.query(
        _tableName,
        where: 'id_dispositif = ?',
        whereArgs: [dispositifId],
      );

      List<Map<String, dynamic>> results = [];

      for (var placetteEntity in placetteList) {
        var placetteId = placetteEntity['id_placette'];

        Map<String, dynamic> corCyclesPlacettesObj =
            await CorCyclesPlacettesDatabaseImpl
                .getPlacetteCorCyclesPlacettesForDataSync(
                    txn, placetteId, lastSyncTime);

        Map<String, dynamic> arbresObj =
            await ArbresDatabaseImpl.getPlacetteArbresForDataSync(
                txn, placetteId, lastSyncTime);

        Map<String, dynamic> bmsObj =
            await BmsSup30DatabaseImpl.getPlacetteBmSup30ForDataSync(
                txn, placetteId, lastSyncTime);

        Map<String, dynamic> repereObj =
            await ReperesDatabaseImpl.getPlacetteReperesForDataSync(
                txn, placetteId, lastSyncTime);

        results.add({
          ...placetteEntity,
          'corCyclesPlacettes': corCyclesPlacettesObj,
          'arbres': arbresObj,
          'bms': bmsObj,
          'reperes': repereObj
        });
      }
      return results;
    });
  }

  @override
  Future<PlacetteEntity> getPlacette(final int placetteId) async {
    final db = await database;
    PlacetteListEntity placetteList = await db.query(_tableName,
        where: '$_columnId = ?', whereArgs: [placetteId], limit: 1);

    final corCyclePlacetteObj =
        await CorCyclesPlacettesDatabaseImpl.getPlacetteCorCyclesPlacettes(
            db, placetteId);
    final arbresObj =
        await ArbresDatabaseImpl.getPlacetteArbres(db, placetteId);
    final bmsObj =
        await BmsSup30DatabaseImpl.getPlacetteBmSup30(db, placetteId);
    final reperesObj =
        await ReperesDatabaseImpl.getPlacetteReperes(db, placetteId);
    return {
      ...placetteList[0],
      'arbres': arbresObj,
      'bmsSup30': bmsObj,
      'corCyclesPlacettes': corCyclePlacetteObj,
      'reperes': reperesObj
    };
  }

  // Method to get all placettes by dispositifId
  @override
  Future<List<PlacetteEntity>> getPlacettesByDispositifId(
      final int dispositifId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'id_dispositif = ?',
      whereArgs: [dispositifId],
    );

    // Convert the List<Map<String, dynamic>> to List<PlacetteEntity>
    return maps;
  }

  @override
  Future<void> deletePlacette(final int id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<PlacetteEntity> updatePlacette(final PlacetteEntity placette) async {
    final db = await database;
    final int id = placette['id_placette']; // Corrected field access for id.

    late final PlacetteEntity updatedPlacette;
    await db.transaction((txn) async {
      var count = await txn.update(
        _tableName,
        placette,
        where: '$_columnId = ?',
        whereArgs: [id],
      );

      final results =
          await txn.query(_tableName, where: '$_columnId = ?', whereArgs: [id]);

      if (results.isNotEmpty) {
        // Assuming you have a method to convert a Map to a PlacetteEntity
        updatedPlacette = results.first;
      } else {
        throw Exception("No placette found with id $id");
      }
    });

    return updatedPlacette;
  }
  // @override
  // Future<void> updatePlacette(final PlacetteEntity placette) async {
  //   final db = await database;
  //   final int id = placette['id'];
  //   await db.update(
  //     _tableName,
  //     placette,
  //     where: '$_columnId = ?',
  //     whereArgs: [id],
  //   );
  // }

  // @override
  // Future<void> deletePlacette(final int id) async {
  //   final db = await database;
  //   await db.delete(
  //     _tableName,
  //     where: '$_columnId = ?',
  //     whereArgs: [id],
  //   );
  // }
}
