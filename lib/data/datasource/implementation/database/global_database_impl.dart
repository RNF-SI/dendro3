import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/data/datasource/interface/database/dispositifs_database.dart';
import 'package:dendro3/data/datasource/interface/database/global_database.dart';
import 'package:dendro3/data/entity/dispositifs_entity.dart';
import 'package:dendro3/data/entity/essences_entity.dart';
import 'package:dendro3/domain/model/essence_list.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class GlobalDatabaseImpl implements GlobalDatabase {
  Future<Database> get database async {
    return await DB.instance.database;
  }

  @override
  Future<Database> initDatabase() async {
    return await DB.instance.database;
  }

  @override
  Future<void> insertEssences(EssenceListEntity essenceListEntity) async {
    final db = await database;
    await db.transaction((txn) async {
      Batch batch = txn.batch();

      essenceListEntity.map((essenceEntity) async {
        final essenceInsertProperties = {
          for (var property in essenceEntity.keys.where((k) =>
              k == 'code_essence' ||
              k == 'cd_nom' ||
              k == 'nom' ||
              k == 'nom_latin' ||
              k == 'ess_reg' ||
              k == 'couleur'))
            property: essenceEntity[property]
        };
        batch.insert(
          'bib_essences',
          essenceInsertProperties,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }).toList();
      await batch.commit();
    });
  }

  @override
  Future<bool> checkBibEssenceEmpty() async {
    final db = await database;
    final tempEssence = await db.query('bib_essences', limit: 1);
    return tempEssence.isEmpty ? true : false;
  }
}
