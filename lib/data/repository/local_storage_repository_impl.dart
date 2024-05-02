import 'package:dendro3/core/helpers/format_DateTime.dart';
import 'package:dendro3/domain/repository/local_storage_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageRepositoryImpl implements LocalStorageRepository {
  static SharedPreferences? _preferences;
  static const String inProgressCorCyclePlacetteKey =
      'inProgressCorCyclePlacetteIdList';
  static const String _lastSyncPrefix = 'lastSyncTime_';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  Future<void> setCyclePlacetteCreated(String idCyclePlacette) async {
    List<String> inProgressList = _getInProgressList();
    inProgressList.add(idCyclePlacette);
    await _preferences?.setStringList(inProgressCorCyclePlacetteKey,
        inProgressList.map((e) => e.toString()).toList());
  }

  @override
  Future<void> completeCyclePlacetteCreated(String idCyclePlacette) async {
    List<String> inProgressList = _getInProgressList();
    inProgressList.remove(idCyclePlacette);
    await _preferences?.setStringList(inProgressCorCyclePlacetteKey,
        inProgressList.map((e) => e.toString()).toList());
  }

  @override
  bool isCyclePlacetteCreated(String idCyclePlacette) {
    List<String> inProgressList = _getInProgressList();
    return !inProgressList.contains(idCyclePlacette);
  }

  List<String> _getInProgressList() {
    return _preferences
            ?.getStringList(inProgressCorCyclePlacetteKey)
            ?.map((e) => e.toString())
            .toList() ??
        [];
  }

  @override
  List<String> getInProgressCorCyclePlacette() {
    return _getInProgressList();
  }

  @override
  Future<void> removeFromInProgressCorCyclePlacette(
      String idCyclePlacette) async {
    List<String> inProgressList = _getInProgressList();
    inProgressList.remove(idCyclePlacette);

    await _preferences?.setStringList(inProgressCorCyclePlacetteKey,
        inProgressList.map((e) => e.toString()).toList());
  }

  @override
  Future<void> setLastSyncTimeForDispositif(
      int dispositifId, DateTime time) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = '$_lastSyncPrefix$dispositifId';
    String formattedTime = formatDateTime(time);
    await prefs.setString(key, formattedTime);
  }

  @override
  Future<String?> getLastSyncTimeForDispositif(int dispositifId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = '$_lastSyncPrefix$dispositifId';
    final String? lastSyncString = prefs.getString(key);
    return lastSyncString;
  }

  @override
  Future<int> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('userId');
    return int.parse(userId!);
  }

  @override
  Future<void> setUserId(int userId) async {
    await _preferences?.setString('userId', userId.toString());
  }

  @override
  Future<void> setUserName(String userName) async {
    await _preferences?.setString('userName', userName);
  }

  @override
  Future<String?> getUserName() async {
    return _preferences?.getString('userName');
  }

  @override
  Future<void> setTerminalName(String terminalName) async {
    await _preferences?.setString('terminalName', terminalName);
  }

  @override
  Future<String?> getTerminalName() async {
    return _preferences?.getString('terminalName');
  }
}
