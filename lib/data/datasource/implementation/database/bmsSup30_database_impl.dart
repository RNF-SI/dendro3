import 'package:dendro3/core/helpers/generate_Uuid.dart';
import 'package:dendro3/data/datasource/implementation/database/bmsSup30_mesures_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/core/helpers/format_DateTime.dart';
import 'package:dendro3/data/datasource/interface/database/bmsSup30_database.dart';
import 'package:dendro3/data/entity/bmsSup30Mesures_entity.dart';
import 'package:dendro3/data/entity/bmsSup30_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
          k == 'observation' ||
          k == 'created_by' ||
          k == 'updated_by' ||
          k == 'created_on' ||
          k == 'updated_on' ||
          k == 'created_at' ||
          k == 'updated_at'))
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
    BmSup30ListEntity bmSup30List = await db.query(_tableName,
        where: 'id_placette = ? AND deleted = 0', whereArgs: [placetteId]);

    BmSup30MesureListEntity bmSup30MesureObj;
    return Future.wait(bmSup30List.map((BmSup30Entity bmSup30Entity) async {
      bmSup30MesureObj =
          await BmsSup30MesuresDatabaseImpl.getbmSup30bmsSup30Mesures(
              db, bmSup30Entity["id_bm_sup_30"]);
      return {...bmSup30Entity, 'bm_sup_30_mesures': bmSup30MesureObj};
    }).toList());
  }

  static Future<Map<String, List<Map<String, dynamic>>>>
      getPlacetteBmSup30ForDataSync(
          Transaction txn, final int placetteId, String lastSyncTime) async {
    // Fetch newly created, updated, and deleted BmSup30 records
    var createdBmsup30 = await txn.query(
      _tableName,
      where: 'id_placette = ? AND created_at > ? AND deleted = 0',
      whereArgs: [placetteId, lastSyncTime],
    );
    var updatedBmsup30 = await txn.query(
      _tableName,
      where:
          'id_placette = ? AND updated_at > ? AND created_at <= ? AND deleted = 0',
      whereArgs: [placetteId, lastSyncTime, lastSyncTime],
    );
    var deletedBmsup30 = await txn.query(
      _tableName,
      where: 'id_placette = ? AND deleted = 1 AND updated_at > ?',
      whereArgs: [placetteId, lastSyncTime],
    );

    // Process each list to include bmSup30Mesures
    return {
      "created":
          await _processBmSup30WithMesures(txn, createdBmsup30, lastSyncTime),
      "updated":
          await _processBmSup30WithMesures(txn, updatedBmsup30, lastSyncTime),
      "deleted":
          deletedBmsup30, // Assuming no need to add bmSup30Mesures for deleted records
    };
  }

// Helper function to process bmSup30 and include their measures
  static Future<List<Map<String, dynamic>>> _processBmSup30WithMesures(
      Transaction txn,
      List<BmSup30Entity> bmSup30List,
      String lastSyncTime) async {
    return Future.wait(
        bmSup30List.map((BmSup30MesureEntity bmSup30Entity) async {
      Map<String, BmSup30MesureListEntity> bmSup30MesureObj =
          await BmsSup30MesuresDatabaseImpl
              .getbmSup30bmsSup30MesuresForDataSync(
        txn,
        bmSup30Entity["id_bm_sup_30"],
        lastSyncTime,
      );
      return {...bmSup30Entity, 'bm_sup_30_mesures': bmSup30MesureObj};
    }).toList());
  }

  @override
  // called when one bms is added
  Future<BmSup30Entity> addBmSup30(BmSup30Entity bmSup30) async {
    final db = await database;
    late final BmSup30Entity bmSup30Entity;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('userName') ?? 'Unknown';
    String terminalName = prefs.getString('terminalName') ?? 'Unknown';
    String formattedDate = formatDateTime(DateTime.now());

    await db.transaction((txn) async {
      String idBmsUuid = generateUuid();

      int? maxIdOrig = Sqflite.firstIntValue(await txn.rawQuery(
              'SELECT MAX(id_bm_sup_30_orig) FROM $_tableName WHERE id_placette = ?',
              [bmSup30['id_placette']])) ??
          0;

      bmSup30['id_bm_sup_30'] = idBmsUuid;
      bmSup30['id_bm_sup_30_orig'] = maxIdOrig + 1;
      // Par défaut created_at et update_at sont remplies.
      bmSup30['created_by'] = userName; // Set created_by
      bmSup30['updated_by'] = userName; // Set updated_by on creation as well
      bmSup30['created_on'] = terminalName;
      bmSup30['updated_on'] = terminalName;
      bmSup30['created_at'] = formattedDate;
      bmSup30['updated_at'] = formattedDate;

      await txn.insert(
        _tableName,
        bmSup30,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      final results = await txn
          .query(_tableName, where: '$_columnId = ?', whereArgs: [idBmsUuid]);
      bmSup30Entity = results.first;
    });
    return bmSup30Entity;
  }

  @override
  Future<BmSup30Entity> updateBmSup30(BmSup30Entity bmSup30) async {
    final db = await database;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('userName') ?? 'Unknown';
    String terminalName = prefs.getString('terminalName') ?? 'Unknown';

    late final BmSup30Entity bmSup30Entity;
    await db.transaction((txn) async {
      var updatedBmSup30 = Map<String, dynamic>.from(bmSup30)
        ..['updated_at'] =
            formatDateTime(DateTime.now()) // Add current timestamp
        ..['updated_by'] = userName
        ..['updated_on'] = terminalName;

      await txn.update(
        _tableName,
        updatedBmSup30,
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

  @override
  Future<void> deleteBmSup30(final String id) async {
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
  Future<List<String>> getBmSup30IdsForPlacette(final int idPlacette) async {
    final db = await database;
    final results = await db.query(_tableName,
        columns: [_columnId],
        where: 'id_placette = ? AND deleted = 0',
        whereArgs: [idPlacette]);
    return results.map((e) => e[_columnId] as String).toList();
  }

  @override
  Future<void> actualizeBmIdBmSup30OrigAfterSync(
      List<Map<String, dynamic>> bmsList) async {
    final db = await database;

    // Iterate over the list of arbres data
    for (var bmData in bmsList) {
      if (bmData['status'] == 'created') {
        // Fetch the Bm object based on idArbre
        var bm = await db.query(_tableName,
            where: '$_columnId = ?', whereArgs: [bmData['id']]);
        if (bm.isNotEmpty) {
          // Update the Bm object's id_bm_sup_30_orig
          await db.update(
            _tableName,
            {'id_bm_sup_30_orig': bmData['new_id_bm_orig']},
            where: '$_columnId = ?',
            whereArgs: [bmData['id']],
          );
        }
      }
    }
  }

  @override
  Future<void> setBmSup30AsUpdated(final String idBmSup30) async {
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
      },
      where: '$_columnId = ?',
      whereArgs: [idBmSup30],
    );
  }
}
