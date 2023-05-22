import 'package:dendro3/data/entity/dispositifs_entity.dart';
import 'package:dendro3/data/entity/essences_entity.dart';
import 'package:dendro3/domain/model/essence_list.dart';

abstract class EssencesDatabase {
  Future<EssenceListEntity> getEssenceList();
  // Future<void> insertEssences(EssenceListEntity essenceList);
  // Future<bool> checkBibEssenceEmpty();
}
