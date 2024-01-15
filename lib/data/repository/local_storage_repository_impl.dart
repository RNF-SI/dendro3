import 'package:dendro3/domain/repository/local_storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageRepositoryImpl implements LocalStorageRepository {
  static SharedPreferences? _preferences;
  static const String inProgressCorCyclePlacetteKey =
      'inProgressCorCyclePlacetteIdList';

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
}
