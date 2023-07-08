import 'package:dendro3/data/entity/transects_entity.dart';

abstract class TransectsDatabase {
  // Future<TransectListEntity> allTransects();
  Future<TransectEntity> addTransect(final TransectEntity transectEntity);
  // Future<void> updateTransect(final TransectEntity transectEntity);
  // Future<void> deleteTransect(final int id);
}
