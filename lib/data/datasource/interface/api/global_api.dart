import 'package:dendro3/data/entity/essences_entity.dart';

abstract class GlobalApi {
  Future<EssenceListEntity> getBibEssences();
}
