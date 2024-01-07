abstract class LocalStorageRepository {
  Future<void> setCyclePlacetteCreated(int idCyclePlacette);
  Future<void> completeCyclePlacetteCreated(int idCyclePlacette);
  bool isCyclePlacetteCreated(int idCyclePlacette);
}
