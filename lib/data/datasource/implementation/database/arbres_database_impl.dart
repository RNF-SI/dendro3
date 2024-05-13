import 'package:dendro3/core/helpers/generate_Uuid.dart';
import 'package:dendro3/data/datasource/implementation/database/arbres_mesures_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/core/helpers/format_DateTime.dart';
import 'package:dendro3/data/datasource/implementation/database/log_error.dart';
import 'package:dendro3/data/datasource/interface/database/arbres_database.dart';
import 'package:dendro3/data/entity/arbresMesures_entity.dart';
import 'package:dendro3/data/entity/arbres_entity.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  // Only used for download Dispositif
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
          k == 'observation' ||
          k == 'created_by' ||
          k == 'updated_by' ||
          k == 'created_on' ||
          k == 'updated_on' ||
          k == 'created_at' ||
          k == 'updated_at'))
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
      Transaction txn, final int placetteId, String lastSyncTime) async {
    // Fetch newly created arbres (created_at after lastSyncTime and not deleted)
    List<ArbreEntity> createdArbres = await txn.query(
      _tableName,
      where: 'id_placette = ? AND created_at > ? AND deleted = 0',
      whereArgs: [placetteId, lastSyncTime],
    );

    // Fetch updated arbres (updated_at after lastSyncTime and not deleted)
    List<ArbreEntity> updatedArbres = await txn.query(
      _tableName,
      where:
          'id_placette = ? AND updated_at > ? AND created_at <= ? AND deleted = 0',
      whereArgs: [placetteId, lastSyncTime, lastSyncTime],
    );

    // Fetch deleted arbres (deleted flag set and updated_at after lastSyncTime)
    List<ArbreEntity> deletedArbres = await txn.query(
      _tableName,
      where: 'id_placette = ? AND deleted = 1 AND updated_at > ?',
      whereArgs: [placetteId, lastSyncTime],
    );

    // Process each list to include arbre_mesures, if needed
    Map<String, List<ArbreEntity>> arbreData = {
      "created":
          await _processArbresWithMesures(txn, createdArbres, lastSyncTime),
      "updated":
          await _processArbresWithMesures(txn, updatedArbres, lastSyncTime),
      "deleted":
          deletedArbres, // Assuming no need to add arbre_mesures for deleted arbres
    };

    return arbreData;
  }

  // Helper function to process arbres and include their measures
  static Future<List<ArbreEntity>> _processArbresWithMesures(
      Transaction txn, List<ArbreEntity> arbres, String lastSyncTime) async {
    return Future.wait(arbres.map((ArbreEntity arbreEntity) async {
      Map<String, List<ArbreMesureEntity>> arbreMesureObj =
          await ArbresMesuresDatabaseImpl.getArbreArbresMesuresForDataSync(
              txn,
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('userName') ?? 'Unknown';
    String terminalName = prefs.getString('terminalName') ?? 'Unknown';
    String formattedDate = formatDateTime(DateTime.now());

    await db.transaction((txn) async {
      String idArbreUuid = generateUuid();

      int? maxIdOrig = Sqflite.firstIntValue(await txn.rawQuery(
              'SELECT MAX(id_arbre_orig) FROM $_tableName WHERE id_placette = ?',
              [arbre['id_placette']])) ??
          0;

      arbre['id_arbre'] = idArbreUuid;
      arbre['id_arbre_orig'] = maxIdOrig + 1;
      // Par défaut created_at et update_at sont remplies.
      arbre['created_by'] = userName; // Set created_by
      arbre['updated_by'] = userName; // Set updated_by on creation as well
      arbre['created_on'] = terminalName;
      arbre['updated_on'] = terminalName;
      arbre['created_at'] = formattedDate;
      arbre['updated_at'] = formattedDate;
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('userName') ?? 'Unknown';
    String terminalName = prefs.getString('terminalName') ?? 'Unknown';

    late final ArbreEntity arbreEntity;
    await db.transaction((txn) async {
      var updatedArbre = Map<String, dynamic>.from(arbre)
        ..['updated_at'] =
            formatDateTime(DateTime.now()) // Add current timestamp
        ..['updated_by'] = userName
        ..['updated_on'] = terminalName;

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('userName') ?? 'Unknown';
    String terminalName = prefs.getString('terminalName') ?? 'Unknown';
    String formattedDate = formatDateTime(DateTime.now());

    await db.update(
      _tableName,
      {
        'deleted': 1,
        'updated_at': formattedDate,
        'updated_by': userName,
        'updated_on': terminalName,
      }, // Mark the record as deleted
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

  @override
  Future<void> actualizeArbreIdArbreOrigAfterSync(
      List<Map<String, dynamic>> arbresList) async {
    final db =
        await database; // Assuming database is a Future or already opened instance

    // Iterate over the list of arbres data
    for (var arbreData in arbresList) {
      if (arbreData['status'] == 'created') {
        // Fetch the Arbre object based on idArbre
        var arbre = await db.query(_tableName,
            where: '$_columnId = ?', whereArgs: [arbreData['id']]);
        if (arbre.isNotEmpty) {
          // Update the Arbre object's idArbreOrig
          await db.update(
            _tableName,
            {'id_arbre_orig': arbreData['new_id_arbre_orig']},
            where: '$_columnId = ?',
            whereArgs: [arbreData['id']],
          );
        }
      }
    }
  }

  // Fonction qui permet juste de d'actualiser la date d'update de l'arbre lorsqu'un
  // arbremesure a été supprimé
  @override
  Future<void> setArbreAsUpdated(String idArbre) async {
    final db = await database;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('userName') ?? 'Unknown';
    String terminalName = prefs.getString('terminalName') ?? 'Unknown';
    String formattedDate = formatDateTime(DateTime.now());

    await db.update(
      _tableName,
      {
        'updated_at': formattedDate,
        'updated_by': userName,
        'updated_on': terminalName,
      }, // Mark the record as deleted
      where: '$_columnId = ?',
      whereArgs: [idArbre],
    );
  }
}
