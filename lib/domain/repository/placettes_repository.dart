import 'package:dendro3/domain/model/placette.dart';

abstract class PlacettesRepository {
  Future<Placette> getPlacette(int placetteId);
  Future<List<Placette>> getPlacettesForDispositif(int dispositifId);
  Future<void> deletePlacetteAndSubObject(int placetteId);
  Future<Placette> updatePlacette(
    int idPlacette,
    double pente,
    int exposition,
  );
}
