import 'package:dendro3/data/entity/corCyclesPlacettes_entity.dart';

abstract class CorCyclesPlacettesDatabase {
  // Future<CorCyclePlacetteListEntity> allCorCyclesPlacettes();
  Future<CorCyclePlacetteEntity> addCorCyclePlacette(
      final CorCyclePlacetteEntity corCyclePlacetteEntity);
  Future<CorCyclePlacetteEntity> updateCorCyclePlacette(
      final CorCyclePlacetteEntity corCyclePlacetteEntity);
  // Future<void> deleteCorCyclePlacette(final int id);

  Future<List<String>> getCorCyclePlacetteIdsForPlacette(final int placetteId);

  Future<void> deleteCorCyclePlacette(String corCyclePlacetteId);
}
