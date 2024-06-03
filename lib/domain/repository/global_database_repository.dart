abstract class GlobalDatabaseRepository {
  Future<void> initDatabase();
  Future<void> deleteDatabase();
  Future<void> exportDatabase();
}
