import 'package:dendro3/core/helpers/generate_Uuid.dart';
import 'package:dendro3/data/datasource/implementation/database/arbres_mesures_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/core/helpers/format_DateTime.dart';
import 'package:dendro3/data/datasource/implementation/database/log_error.dart';
import 'package:dendro3/data/datasource/interface/database/arbres_database.dart';
import 'package:dendro3/data/entity/arbresMesures_entity.dart';
import 'package:dendro3/data/entity/arbres_entity.dart';
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
    ArbreListEntity arbreList = await db.query(
      _tableName,
      where: 'id_placette = ? AND deleted = 0',
      whereArgs: [placetteId],
    );

    var arbreMesureObj;

    return Future.wait(arbreList.map((ArbreEntity arbreEntity) async {
      ArbreMesureListEntity arbreMesureObj =
          await ArbresMesuresDatabaseImpl.getArbreArbresMesures(
              db, arbreEntity["id_arbre"]);
      return {...arbreEntity, 'arbres_mesures': arbreMesureObj};
    }).toList());
  }

  static Future<Map<String, List<ArbreEntity>>> getPlacetteArbresForDataSync(
      Database db, final int placetteId, String lastSyncTime) async {
    // Fetch newly created arbres (created_at after lastSyncTime and not deleted)
    List<ArbreEntity> createdArbres = await db.query(
      _tableName,
      where: 'id_placette = ? AND created_at > ? AND deleted = 0',
      whereArgs: [placetteId, lastSyncTime],
    );

    // Fetch updated arbres (updated_at after lastSyncTime and not deleted)
    List<ArbreEntity> updatedArbres = await db.query(
      _tableName,
      where:
          'id_placette = ? AND updated_at > ? AND created_at <= ? AND deleted = 0',
      whereArgs: [placetteId, lastSyncTime, lastSyncTime],
    );

    // Fetch deleted arbres (deleted flag set and updated_at after lastSyncTime)
    List<ArbreEntity> deletedArbres = await db.query(
      _tableName,
      where: 'id_placette = ? AND deleted = 1 AND updated_at > ?',
      whereArgs: [placetteId, lastSyncTime],
    );

    // Process each list to include arbre_mesures, if needed
    Map<String, List<ArbreEntity>> arbreData = {
      "created":
          await _processArbresWithMesures(db, createdArbres, lastSyncTime),
      "updated":
          await _processArbresWithMesures(db, updatedArbres, lastSyncTime),
      "deleted":
          deletedArbres // Assuming no need to add arbre_mesures for deleted arbres
    };

    return arbreData;
  }

  // Helper function to process arbres and include their measures
  static Future<List<ArbreEntity>> _processArbresWithMesures(
      Database db, List<ArbreEntity> arbres, String lastSyncTime) async {
    return Future.wait(arbres.map((ArbreEntity arbreEntity) async {
      Map<String, List<ArbreMesureEntity>> arbreMesureObj =
          await ArbresMesuresDatabaseImpl.getArbreArbresMesuresForDataSync(
              db,
              arbreEntity["id_arbre"],
              lastSyncTime); // Assuming you also update getArbreArbresMesures similarly
      return {...arbreEntity, 'arbres_mesures': arbreMesureObj};
    }).toList());
  }

  @override
  // Function called when one arbre is added (not adding arbre mesure)
  Future<ArbreEntity> addArbre(final ArbreEntity arbre) async {
    final db = await database;
    late final ArbreEntity arbreEntity;
    await db.transaction((txn) async {
      String idArbreUuid = generateUuid();

      int? maxIdOrig = Sqflite.firstIntValue(await txn.rawQuery(
              'SELECT MAX(id_arbre_orig) FROM $_tableName WHERE id_placette = ?',
              [arbre['id_placette']])) ??
          0;

      arbre['id_arbre'] = idArbreUuid;
      arbre['id_arbre_orig'] = maxIdOrig + 1;
      await txn.insert(
        _tableName,
        arbre,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      final results = await txn
          .query(_tableName, where: '$_columnId = ?', whereArgs: [idArbreUuid]);
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
      var updatedArbre = Map<String, dynamic>.from(arbre)
        ..['updated_at'] =
            formatDateTime(DateTime.now()); // Add current timestamp

      await txn.update(
        _tableName,
        updatedArbre,
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
  Future<void> deleteArbre(final String id) async {
    final db = await database;
    await db.update(
      _tableName,
      {'deleted': 1}, // Mark the record as deleted
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<String>> getArbreIdsForPlacette(final int idPlacette) async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        _tableName,
        columns: [_columnId],
        where: 'id_placette = ? AND deleted = 0',
        whereArgs: [idPlacette],
      );
      return List.generate(maps.length, (i) => maps[i][_columnId]);
    } on Exception catch (e, stackTrace) {
      logError(
          e, stackTrace, 'getArbreIdsForPlacette', {'idPlacette': idPlacette});
      return []; // or rethrow, depending on how you want to handle the error
    }
  }
}
