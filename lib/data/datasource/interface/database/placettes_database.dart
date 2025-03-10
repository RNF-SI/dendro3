import 'package:dendro3/data/entity/placettes_entity.dart';

abstract class PlacettesDatabase {
  // Future<PlacetteListEntity> allPlacettes();
  // Future<PlacetteEntity> insertPlacette(
  //     final PlacetteEntity placetteEntity);
  Future<PlacetteEntity> getPlacette(final int placetteId);
  Future<List<PlacetteEntity>> getPlacettesByDispositifId(
      final int dispositifId);
  Future<void> deletePlacette(final int id);
  Future<PlacetteEntity> updatePlacette(final PlacetteEntity placetteEntity);
  // Future<void> updatePlacette(final PlacetteEntity placetteEntity);
  // Future<void> deletePlacette(final int id);
}
