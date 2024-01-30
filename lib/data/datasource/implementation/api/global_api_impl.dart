
import 'package:dendro3/data/datasource/interface/api/global_api.dart';
import 'package:dendro3/data/entity/essences_entity.dart';
import 'package:dendro3/data/entity/nomencluresTypes_entity.dart';
import 'package:dendro3/data/entity/nomenclatures_entity.dart';
import 'package:dio/dio.dart';

const String apiBase = "http://10.0.2.2:8000";
// const String apiBase = "http://192.168.1.64:8000";

class GlobalApiImpl implements GlobalApi {
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
}
