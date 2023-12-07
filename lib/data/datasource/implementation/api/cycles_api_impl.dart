import 'dart:convert';
import 'dart:io';

import 'package:dendro3/core/error/failure.dart';
import 'package:dendro3/data/datasource/interface/api/cycles_api.dart';
import 'package:dendro3/data/datasource/interface/api/dispositifs_api.dart';
import 'package:dendro3/data/entity/cycles_entity.dart';
import 'package:dendro3/data/entity/dispositifs_entity.dart';
import 'package:dendro3/domain/model/cycle_list.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

const String apiBase = "http://10.0.2.2:8000";
// const String apiBase = "https://192.168.122.1:8000";

class CyclesApiImpl implements CyclesApi {
  @override
  Future<CycleListEntity> getDispositifCycles(final int dispId) async {
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
