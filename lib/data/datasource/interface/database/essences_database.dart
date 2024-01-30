import 'package:dendro3/data/entity/essences_entity.dart';

abstract class EssencesDatabase {
  Future<EssenceListEntity> getEssenceList();
  // Future<void> insertEssences(EssenceListEntity essenceList);
  // Future<bool> checkBibEssenceEmpty();
}
