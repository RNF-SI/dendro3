import 'package:dendro3/data/datasource/implementation/database/cycles_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/data/datasource/implementation/database/global_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/placettes_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/reperes_database_impl.dart';
import 'package:dendro3/data/datasource/interface/database/essences_database.dart';
import 'package:dendro3/data/entity/essences_entity.dart';
import 'package:dendro3/domain/model/essence_list.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class EssencesDatabaseImpl implements EssencesDatabase {
  static const _tableName = 'bib_essences';

  Future<Database> get database async {
    return await DB.instance.database;
  }

  @override
  Future<EssenceListEntity> getEssenceList() async {
    final db = await database;
    return db.query(_tableName);
  }
}
