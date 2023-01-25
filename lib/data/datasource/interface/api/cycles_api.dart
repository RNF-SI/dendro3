import 'package:dendro3/data/entity/cycles_entity.dart';
import 'package:dendro3/data/entity/dispositifs_entity.dart';

abstract class CyclesApi {
  Future<CycleListEntity> getDispositifCycles(final int dispId);
}
