import 'package:dendro3/core/helpers/format_DateTime.dart';
import 'package:dendro3/domain/repository/local_storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  Future<void> setCyclePlacetteCreated(int idCyclePlacette) async {
    List<int> inProgressList = _getInProgressList();
    inProgressList.add(idCyclePlacette);
    await _preferences?.setStringList(inProgressCorCyclePlacetteKey,
        inProgressList.map((e) => e.toString()).toList());
  }

  @override
  Future<void> completeCyclePlacetteCreated(int idCyclePlacette) async {
    List<int> inProgressList = _getInProgressList();
    inProgressList.remove(idCyclePlacette);
    await _preferences?.setStringList(inProgressCorCyclePlacetteKey,
        inProgressList.map((e) => e.toString()).toList());
  }

  @override
  bool isCyclePlacetteCreated(int idCyclePlacette) {
    List<int> inProgressList = _getInProgressList();
    return !inProgressList.contains(idCyclePlacette);
  }

  List<int> _getInProgressList() {
    return _preferences
            ?.getStringList(inProgressCorCyclePlacetteKey)
            ?.map((e) => int.parse(e))
            .toList() ??
        [];
  }

  @override
  List<int> getInProgressCorCyclePlacette() {
    return _getInProgressList();
  }

  @override
  Future<void> removeFromInProgressCorCyclePlacette(int idCyclePlacette) async {
    List<int> inProgressList = _getInProgressList();
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
  Future<DateTime?> getLastSyncTimeForDispositif(int dispositifId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = '$_lastSyncPrefix$dispositifId';
    final String? lastSyncString = prefs.getString(key);
    if (lastSyncString != null) {
      return DateTime.parse(lastSyncString);
    }
    return null;
  }
}
