import 'package:dendro3/data/entity/essences_entity.dart';
import 'package:dendro3/data/entity/nomenclatures_entity.dart';
import 'package:dendro3/data/entity/nomencluresTypes_entity.dart';

abstract class GlobalDatabase {
  Future<void> initDatabase();
  Future<void> insertEssences(EssenceListEntity essenceList);
  Future<bool> checkBibEssenceEmpty();

  Future<bool> checkBibNomenclaturesTypesEmpty();

  Future<void> insertBibNomenclaturesTypes(NomenclatureTypeListEntity list);

  Future<bool> checkNomenclaturesEmpty();

  Future<void> insertNomenclatures(NomenclatureListEntity list);

  Future<void> deleteAndReinitializeCurrentDatabase();

  Future<void> exportDatabase();

  Future<void> refreshNomenclatures(NomenclatureListEntity list);
}
