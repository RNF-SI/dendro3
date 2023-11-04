import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/data/entity/nomenclatures_entity.dart';
import 'package:sqflite/sqflite.dart';

abstract class NomenclaturesDatabase {
  Future<NomenclatureListEntity> getNomenclatureList();
  Future<NomenclatureListEntity> getNomenclatureListFromIdType(int idType);
}
