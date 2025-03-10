import 'package:dendro3/data/entity/cycles_entity.dart';

abstract class CyclesDatabase {
  // Future<CycleListEntity> allCycles();
  // Future<CycleEntity> insertCycle(
  //     final CycleEntity cycleEntity);
  // Future<void> updateCycle(final CycleEntity cycleEntity);
  Future<void> deleteCycle(final int id);
  Future<CycleListEntity> getDispositifCycles(final int dispId);
  Future<void> addCycle(final CycleEntity cycleEntity);
  Future<void> updateCycle(final CycleEntity cycleEntity);
  Future<void> deleteCycleFromDispositifId(final int dispositifId);
}
