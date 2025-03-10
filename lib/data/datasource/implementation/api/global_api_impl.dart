import 'package:dendro3/data/datasource/interface/api/global_api.dart';
import 'package:dendro3/data/entity/essences_entity.dart';
import 'package:dendro3/data/entity/nomencluresTypes_entity.dart';
import 'package:dendro3/data/entity/nomenclatures_entity.dart';
import 'package:dendro3/config/config.dart';
import 'package:dio/dio.dart';

class GlobalApiImpl implements GlobalApi {
  var apiBase = Config.apiBase;

  @override
  Future<EssenceListEntity> getBibEssences() async {
    Response response = await Dio().get('$apiBase/psdrf/essences');
    EssenceListEntity essenceListEnt = [];
    EssenceEntity essenceEnt = {};

    for (var i = 0; i < response.data.length; i++) {
      var currentElement = response.data[i];
      essenceEnt = {};
      currentElement.forEach((k, v) => {essenceEnt[k] = v});
      essenceListEnt.add(essenceEnt);
    }
    return essenceListEnt;
  }

  @override
  Future<NomenclatureTypeListEntity> getBibNomenclaturesTypes() async {
    try {
      Response response =
          await Dio().get('$apiBase/psdrf/bib_nomenclatures_types');
      NomenclatureTypeListEntity nomenclatureTypeListEnt = [];
      NomenclatureTypeEntity nomenclatureTypeEnt = {};

      for (var i = 0; i < response.data.length; i++) {
        var currentElement = response.data[i];
        nomenclatureTypeEnt = {};
        currentElement.forEach((k, v) => {nomenclatureTypeEnt[k] = v});
        nomenclatureTypeListEnt.add(nomenclatureTypeEnt);
      }
      return nomenclatureTypeListEnt;
    } catch (e) {
      throw Exception('Failed to fetch nomenclature types: $e');
    }
  }

  @override
  Future<NomenclatureListEntity> getNomenclatures() async {
    Response response = await Dio().get('$apiBase/psdrf/t_nomenclatures');
    NomenclatureListEntity nomenclatureListEnt = [];
    NomenclatureEntity nomenclatureEnt = {};

    for (var i = 0; i < response.data.length; i++) {
      var currentElement = response.data[i];
      nomenclatureEnt = {};
      currentElement.forEach((k, v) => {nomenclatureEnt[k] = v});
      nomenclatureListEnt.add(nomenclatureEnt);
    }
    return nomenclatureListEnt;
  }

  @override
  Future<NomenclatureListEntity> refreshNomenclatures() async {
    try {
      Response response = await Dio().get('$apiBase/psdrf/t_nomenclatures');
      NomenclatureListEntity nomenclatureListEnt = [];
      NomenclatureEntity nomenclatureEnt = {};

      for (var i = 0; i < response.data.length; i++) {
        var currentElement = response.data[i];
        nomenclatureEnt = {};
        currentElement.forEach((k, v) => {nomenclatureEnt[k] = v});
        nomenclatureListEnt.add(nomenclatureEnt);
      }
      return nomenclatureListEnt;
    } catch (e) {
      throw Exception('Failed to fetch nomenclatures: $e');
    }
  }
}
