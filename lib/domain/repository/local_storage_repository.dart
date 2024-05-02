abstract class LocalStorageRepository {
  Future<void> setCyclePlacetteCreated(String idCyclePlacette);
  Future<void> completeCyclePlacetteCreated(String idCyclePlacette);
  bool isCyclePlacetteCreated(String idCyclePlacette);
  List<String> getInProgressCorCyclePlacette();
  Future<void> removeFromInProgressCorCyclePlacette(String idCyclePlacette);
  Future<void> setLastSyncTimeForDispositif(
      int dispositifId, DateTime dateTime);
  Future<String?> getLastSyncTimeForDispositif(int dispositifId);
  Future<int> getUserId();
  Future<void> setUserId(int userId);
  Future<void> setUserName(String userName);
  Future<String?> getUserName();
}
