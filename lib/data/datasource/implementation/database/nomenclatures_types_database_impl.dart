import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/data/datasource/interface/database/nomenclatures_types_database.dart';
import 'package:dendro3/data/entity/nomencluresTypes_entity.dart';
import 'package:sqflite/sqflite.dart';

class NomenclaturesTypesDatabaseImpl implements NomenclaturesTypesDatabase {
  static const _tableName = 'bib_nomenclatures_types';

  Future<Database> get database async {
    return await DB.instance.database;
  }

  @override
  Future<NomenclatureTypeListEntity> getNomenclatureTypeList() async {
    final db = await database;
    return db.query(_tableName);
  }

  @override
  Future<NomenclatureTypeEntity> getNomenclatureTypeFromMnemonique(
      String s) async {
    final db = await database;
    // Renvoyer le premier élément de la liste
    final results =
        await db.query(_tableName, where: 'mnemonique = ?', whereArgs: [s]);
    return results.first;
  }
}
