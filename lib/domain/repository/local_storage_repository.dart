abstract class LocalStorageRepository {
  Future<void> setCyclePlacetteCreated(int idCyclePlacette);
  Future<void> completeCyclePlacetteCreated(int idCyclePlacette);
  bool isCyclePlacetteCreated(int idCyclePlacette);
  List<int> getInProgressCorCyclePlacette();
  Future<void> removeFromInProgressCorCyclePlacette(int idCyclePlacette);
  Future<void> setLastSyncTimeForDispositif(
      int dispositifId, DateTime dateTime);
  Future<String?> getLastSyncTimeForDispositif(int dispositifId);
}
