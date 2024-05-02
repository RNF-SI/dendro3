import 'package:dendro3/data/entity/nomencluresTypes_entity.dart';

abstract class NomenclaturesTypesDatabase {
  Future<NomenclatureTypeListEntity> getNomenclatureTypeList();
  Future<NomenclatureTypeEntity> getNomenclatureTypeFromMnemonique(String s);
}
