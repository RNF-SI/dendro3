import 'package:dendro3/data/datasource/interface/api/cycles_api.dart';
import 'package:dendro3/data/entity/cycles_entity.dart';
import 'package:dendro3/config/config.dart';
import 'package:dio/dio.dart';

class CyclesApiImpl implements CyclesApi {
  @override
  Future<CycleListEntity> getDispositifCycles(final int dispId) async {
    var apiBase = Config.apiBase;
    Response response =
        await Dio().get("$apiBase/psdrf/dispositif-cycles/$dispId");
    CycleListEntity dispListEnt = [];
    CycleEntity dispEnt = {};

    for (var i = 0; i < response.data.length; i++) {
      var currentElement = response.data[i];
      dispEnt = {};
      currentElement.forEach((k, v) => {dispEnt[k] = v});
      dispListEnt.add(dispEnt);
    }
    return dispListEnt;
  }
}
