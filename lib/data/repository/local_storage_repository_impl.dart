import 'package:dendro3/domain/repository/local_storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageRepositoryImpl implements LocalStorageRepository {
  static SharedPreferences? _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  Future<void> setCyclePlacetteCreated(int idCyclePlacette) async {
    await _preferences?.setBool(idCyclePlacette.toString(), true);
  }

  @override
  Future<void> completeCyclePlacetteCreated(int idCyclePlacette) async {
    await _preferences?.setBool(idCyclePlacette.toString(), false);
  }

  @override
  bool isCyclePlacetteCreated(int idCyclePlacette) {
    return _preferences?.getBool(idCyclePlacette.toString()) ?? false;
  }
}
