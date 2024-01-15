import 'package:dendro3/data/entity/transects_entity.dart';

abstract class TransectsDatabase {
  // Future<TransectListEntity> allTransects();
  Future<TransectEntity> addTransect(final TransectEntity transectEntity);
  Future<TransectEntity> updateTransect(final TransectEntity transectEntity);
  Future<void> deleteTransect(final int id);
  Future<void> deleteTransectsForCorCyclePlacette(int corCyclePlacetteId);
}
