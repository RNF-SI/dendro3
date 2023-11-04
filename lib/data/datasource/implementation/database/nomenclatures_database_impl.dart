import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/data/datasource/interface/database/nomenclatures_database.dart';
import 'package:dendro3/data/entity/nomenclatures_entity.dart';
import 'package:sqflite/sqflite.dart';

class NomenclaturesDatabaseImpl implements NomenclaturesDatabase {
  static const _tableName = 't_nomenclatures';

  Future<Database> get database async {
    return await DB.instance.database;
  }

  @override
  Future<NomenclatureListEntity> getNomenclatureList() async {
    final db = await database;
    return db.query(_tableName);
  }

  @override
  Future<NomenclatureListEntity> getNomenclatureListFromIdType(
      int idType) async {
    final db = await database;
    return db.query(_tableName, where: 'id_type = ?', whereArgs: [idType]);
  }
}
