import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/data/entity/nomenclatures_entity.dart';
import 'package:dendro3/data/entity/nomencluresTypes_entity.dart';
import 'package:sqflite/sqflite.dart';

abstract class NomenclaturesTypesDatabase {
  Future<NomenclatureTypeListEntity> getNomenclatureTypeList();
  Future<NomenclatureTypeEntity> getNomenclatureTypeFromMnemonique(String s);
}
