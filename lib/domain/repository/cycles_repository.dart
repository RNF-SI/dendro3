
abstract class CyclesRepository {
  Future<void> updateDispositifCycles(
    final int id,
  );

  Future<void> deleteCycleFromDispositifId(
    final int dispositifId,
  );
}
