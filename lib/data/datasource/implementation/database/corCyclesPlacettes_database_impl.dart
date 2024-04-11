import 'package:dendro3/core/helpers/generate_Uuid.dart';
import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/data/datasource/implementation/database/regenerations_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/transects_database_impl.dart';
import 'package:dendro3/data/datasource/interface/database/corCyclesPlacettes_database.dart';
import 'package:dendro3/data/entity/corCyclesPlacettes_entity.dart';
import 'package:dendro3/data/entity/regenerations_entity.dart';
import 'package:dendro3/data/entity/transects_entity.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class CorCyclesPlacettesDatabaseImpl implements CorCyclesPlacettesDatabase {
  static const _tableName = 'cor_cycles_placettes';
  static const _columnId = 'id_cycle_placette';

  Future<Database> get database async {
    return await DB.instance.database;
  }

  // @override
  // Future<PlacetteListEntity> allCorCyclesPlacettes() async {
  //   final db = await database;
  //   return db.query(_tableName);
  // }

  static Future<void> insertCorCyclePlacette(
      Batch batch, final CorCyclePlacetteEntity corCyclePlacette) async {
    final corCyclePlacetteInsertProperties = {
      for (var property in corCyclePlacette.keys.where((k) =>
          k == 'id_cycle_placette' ||
          k == 'id_cycle' ||
          k == 'id_placette' ||
          k == 'date_releve' ||
          k == 'date_intervention' ||
          k == 'annee' ||
          k == 'nature_intervention' ||
          k == 'gestion_placette' ||
          k == 'id_nomenclature_castor' ||
          k == 'id_nomenclature_frottis' ||
          k == 'id_nomenclature_boutis' ||
          k == 'recouv_herbes_basses' ||
          k == 'recouv_herbes_hautes' ||
          k == 'recouv_buissons' ||
          k == 'recouv_arbres' ||
          k == 'coeff' ||
          k == 'diam_lim' ||
          k == 'created_by' ||
          k == 'updated_by' ||
          k == 'created_on' ||
          k == 'updated_on' ||
          k == 'created_at' ||
          k == 'updated_at'))
        property: corCyclePlacette[property]
    };

    batch.insert(_tableName, corCyclePlacetteInsertProperties,
        conflictAlgorithm: ConflictAlgorithm.replace);

    corCyclePlacette['transects']
        .map((transect) async =>
            {await TransectsDatabaseImpl.insertTransect(batch, transect)})
        .toList();
    corCyclePlacette['regenerations']
        .map((regeneration) async => {
              await RegenerationsDatabaseImpl.insertRegeneration(
                  batch, regeneration)
            })
        .toList();
  }

  static Future<List<CorCyclePlacetteEntity>> getPlacetteCorCyclesPlacettes(
      Database db, final int placetteId) async {
    CorCyclePlacetteListEntity corCyclePlacetteList = await db.query(_tableName,
        where: 'id_placette = ? AND deleted = 0', whereArgs: [placetteId]);

    var transectObj;

    return Future.wait(corCyclePlacetteList
        .map((CorCyclePlacetteEntity corCyclePlacetteEntity) async {
      TransectListEntity transectObj =
          await TransectsDatabaseImpl.getCorCyclePlacetteTransects(
              db, corCyclePlacetteEntity["id_cycle_placette"]);
      RegenerationListEntity regenerationObj =
          await RegenerationsDatabaseImpl.getCorCyclePlacetteRegenerations(
              db, corCyclePlacetteEntity["id_cycle_placette"]);
      return {
        ...corCyclePlacetteEntity,
        'transects': transectObj,
        'regenerations': regenerationObj
      };
    }).toList());
  }

  static Future<Map<String, List<Map<String, dynamic>>>>
      getPlacetteCorCyclesPlacettesForDataSync(
          Database db, final int placetteId, String lastSyncTime) async {
    // Fetch newly created CorCyclePlacette records
    var createdCorcycleplacette = await db.query(
      _tableName,
      where: 'id_placette = ? AND created_at > ? AND deleted = 0',
      whereArgs: [placetteId, lastSyncTime],
    );

    // Fetch updated CorCyclePlacette records
    var updatedCorcycleplacette = await db.query(
      _tableName,
      where:
          'id_placette = ? AND updated_at > ? AND created_at <= ? AND deleted = 0',
      whereArgs: [placetteId, lastSyncTime, lastSyncTime],
    );

    // Fetch deleted CorCyclePlacette records
    var deletedCorcycleplacette = await db.query(
      _tableName,
      where: 'id_placette = ? AND deleted = 1 AND updated_at > ?',
      whereArgs: [placetteId, lastSyncTime],
    );

    // Process each list to include Transects and Regenerations
    return {
      "created": await _processCorCyclePlacetteWithDetails(
        db,
        createdCorcycleplacette,
        lastSyncTime,
      ),
      "updated": await _processCorCyclePlacetteWithDetails(
        db,
        updatedCorcycleplacette,
        lastSyncTime,
      ),
      "deleted":
          deletedCorcycleplacette, // Assuming no need to add details for deleted records
    };
  }

// Helper function to process CorCyclePlacette and include Transects and Regenerations
  static Future<List<Map<String, dynamic>>> _processCorCyclePlacetteWithDetails(
      Database db,
      List<CorCyclePlacetteEntity> corCyclePlacetteList,
      String lastSyncTime) async {
    return Future.wait(corCyclePlacetteList.map((corCyclePlacetteEntity) async {
      var transectObj =
          await TransectsDatabaseImpl.getCorCyclePlacetteTransectsForDataSync(
              db, corCyclePlacetteEntity["id_cycle_placette"], lastSyncTime);
      var regenerationObj = await RegenerationsDatabaseImpl
          .getCorCyclePlacetteRegenerationsForDataSync(
              db, corCyclePlacetteEntity["id_cycle_placette"], lastSyncTime);
      return {
        ...corCyclePlacetteEntity,
        'transects': transectObj,
        'regenerations': regenerationObj
      };
    }).toList());
  }

  @override
  // Function called when one cor_cycle_placette is added (not add  transect or regeneration)
  Future<CorCyclePlacetteEntity> addCorCyclePlacette(
      final CorCyclePlacetteEntity corCyclePlacette) async {
    final db = await database;
    late final CorCyclePlacetteEntity corCyclePlacetteEntity;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('userName') ?? 'Unknown';
    String terminalName = prefs.getString('terminalName') ?? 'Unknown';

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    corCyclePlacette["date_releve"] =
        formatter.format(corCyclePlacette["date_releve"]);

    await db.transaction((txn) async {
      String corCyclePlacetteUuid = generateUuid();
      corCyclePlacette[_columnId] = corCyclePlacetteUuid;

      // Par défaut created_at et update_at sont remplies.
      corCyclePlacette['created_by'] = userName; // Set created_by
      corCyclePlacette['updated_by'] =
          userName; // Set updated_by on creation as well
      corCyclePlacette['created_on'] = terminalName;
      corCyclePlacette['updated_on'] = terminalName;

      await txn.insert(
        _tableName,
        corCyclePlacette,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      final results = await txn.query(_tableName,
          where: '$_columnId = ?', whereArgs: [corCyclePlacetteUuid]);
      corCyclePlacetteEntity = results.first;
    });
    return corCyclePlacetteEntity;
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

  @override
  Future<List<String>> getCorCyclePlacetteIdsForPlacette(
      final int placetteId) async {
    final db = await database;
    final results = await db.query(
      _tableName,
      columns: [_columnId],
      where: 'id_placette = ? AND deleted = 0',
      whereArgs: [placetteId],
    );
    return results.map((e) => e[_columnId] as String).toList();
  }

  @override
  Future<void> deleteCorCyclePlacette(final String id) async {
    final db = await database;
    await db.update(
      _tableName,
      {'deleted': 1},
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }
}
