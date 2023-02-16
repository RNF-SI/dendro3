import 'dart:convert';
import 'dart:io';

import 'package:dendro3/data/datasource/interface/api/global_api.dart';
import 'package:dendro3/data/entity/essences_entity.dart';
import 'package:dendro3/domain/model/essence_list.dart';
import 'package:dio/dio.dart';

const String apiBase = "http://10.0.2.2:8000";

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
}
