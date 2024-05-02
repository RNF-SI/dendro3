import 'package:dendro3/domain/model/nomenclature_list.dart';

abstract class NomenclaturesRepository {
  Future<NomenclatureList> getNomenclatureList();
  Future<NomenclatureList> getNomenclaturesFromIdType(int idType);
}
