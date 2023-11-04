import 'package:dendro3/domain/model/nomenclature.dart';
import 'package:dendro3/domain/model/nomenclatureType_list.dart';
import 'package:dendro3/domain/model/nomenclature_list.dart';

abstract class NomenclaturesTypesRepository {
  Future<NomenclatureTypeList> getNomenclatureTypeList();

  Future<int> getIdTypeNomenclatureFromMnemonique(String s);
}
