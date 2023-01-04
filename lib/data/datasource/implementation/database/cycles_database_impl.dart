import 'package:dendro3/data/datasource/implementation/database/corCyclesPlacettes_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/data/datasource/implementation/database/global_database_impl.dart';
import 'package:dendro3/data/datasource/interface/database/cycles_database.dart';
import 'package:dendro3/data/entity/cycles_entity.dart';
import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CyclesDatabaseImpl implements CyclesDatabase {
  static const _tableName = 't_cycles';

  Future<Database> get database async {
    return await DB.instance.database;
  }
  // @override
  // Future<CycleListEntity> allCycles() async {
  //   final db = await database;
  //   return db.query(_tableName);
  // }

  static Future<void> insertCycle(Batch batch, final CycleEntity cycle) async {
    final cycleInsertProperties = {
      for (var property in cycle.keys.where((k) =>
          k == 'id_cycle' ||
          k == 'id_dispositif' ||
          k == 'num_cycle' ||
          k == 'coeff' ||
          k == 'date_debut' ||
          k == 'date_fin' ||
          k == 'diam_lim' ||
          k == 'monitor'))
        property: cycle[property]
    };

    batch.insert(_tableName, cycleInsertProperties,
        conflictAlgorithm: ConflictAlgorithm.replace);

    cycle['corCyclesPlacettes']
        .map((corCyclePlacette) async => {
              await CorCyclesPlacettesDatabaseImpl.insertCorCyclePlacette(
                  batch, corCyclePlacette)
            })
        .toList();
  }

  // @override
  // Future<void> updateCycle(final CycleEntity cycle) async {
  //   final db = await database;
  //   final int id = cycle['id'];
  //   await db.update(
  //     _tableName,
  //     cycle,
  //     where: '$_columnId = ?',
  //     whereArgs: [id],
  //   );
  // }

  // @override
  // Future<void> deleteCycle(final int id) async {
  //   final db = await database;
  //   await db.delete(
  //     _tableName,
  //     where: '$_columnId = ?',
  //     whereArgs: [id],
  //   );
  // }

}
