import 'package:dendro3/data/entity/essences_entity.dart';
import 'package:dendro3/data/entity/nomencluresTypes_entity.dart';
import 'package:dendro3/data/entity/nomenclatures_entity.dart';

abstract class GlobalApi {
  Future<EssenceListEntity> getBibEssences();
  Future<NomenclatureTypeListEntity> getBibNomenclaturesTypes();
  Future<NomenclatureListEntity> getNomenclatures();
  Future<NomenclatureListEntity> refreshNomenclatures(); // New method
}
