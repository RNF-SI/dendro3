import 'dart:convert';
import 'dart:io';

import 'package:dendro3/core/error/failure.dart';
import 'package:dendro3/data/datasource/interface/api/dispositifs_api.dart';
import 'package:dendro3/data/entity/dispositifs_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

const String apiBase = "http://10.0.2.2:8000";
// const String apiBase = "https://192.168.122.1:8000";

class DispositifsApiImpl implements DispositifsApi {
  @override
  Future<DispositifListEntity> getAllDispositifs() async {
    Response response = await Dio().get("$apiBase/psdrf/dispositifsList");
    DispositifListEntity list = [];
    DispositifEntity dispEntTemp = {};
    response.data.forEach((d) {
      d.forEach((k, v) => {dispEntTemp[k] = v});
      list.add(dispEntTemp);
      dispEntTemp = {};
    });
    return list;
  }

  @override
  Future<DispositifListEntity> getUserDispositifs(final int userId) async {
    try {
      Response response =
          await Dio().get("$apiBase/psdrf/user-dispositif-list/$userId");
      DispositifListEntity list = [];
      DispositifEntity dispEntTemp = {};
      response.data.forEach((d) {
        d.forEach((k, v) => {dispEntTemp[k] = v});
        list.add(dispEntTemp);
        dispEntTemp = {};
      });
      return list;
    } on DioError catch (err) {
      print(err);
      throw Failure(
          message: err.response?.statusMessage ?? 'Something went wrong!');
    } on SocketException catch (err) {
      print(err);
      throw Failure(message: 'Please check your connection.');
    }
  }

  @override
  Future<DispositifEntity> getDispositifFromId(final int dispId) async {
    Response response =
        await Dio().get("$apiBase/psdrf/dispositif-complet/$dispId");
    DispositifEntity dispEnt = {};
    response.data.forEach((k, v) => {dispEnt[k] = v});
    return dispEnt;
  }
}
