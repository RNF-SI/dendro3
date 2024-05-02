import 'package:dendro3/data/entity/nomenclatures_entity.dart';

abstract class NomenclaturesDatabase {
  Future<NomenclatureListEntity> getNomenclatureList();
  Future<NomenclatureListEntity> getNomenclatureListFromIdType(int idType);
}
