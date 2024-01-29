import 'package:dendro3/data/entity/transects_entity.dart';

abstract class TransectsDatabase {
  // Future<TransectListEntity> allTransects();
  Future<TransectEntity> addTransect(final TransectEntity transectEntity);
  Future<TransectEntity> updateTransect(final TransectEntity transectEntity);
  Future<void> deleteTransect(final String id);
  Future<void> deleteTransectsForCorCyclePlacette(String corCyclePlacetteId);
}
