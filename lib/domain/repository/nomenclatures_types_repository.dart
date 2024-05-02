import 'package:dendro3/domain/model/nomenclatureType_list.dart';

abstract class NomenclaturesTypesRepository {
  Future<NomenclatureTypeList> getNomenclatureTypeList();

  Future<int> getIdTypeNomenclatureFromMnemonique(String s);
}
