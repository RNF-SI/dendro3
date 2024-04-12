import 'dart:io';

import 'package:dendro3/core/error/failure.dart';
import 'package:dendro3/core/helpers/sync_objects.dart';
import 'package:dendro3/data/datasource/interface/api/dispositifs_api.dart';
import 'package:dendro3/data/entity/dispositifs_entity.dart';
import 'package:dendro3/data/common/constants.dart';
import 'package:dio/dio.dart';

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
      throw const Failure(message: 'Please check your connection.');
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

  @override
  Future<SyncResults> exportDispositifData(DispositifEntity data) async {
    try {
      final url = Uri.parse("$apiBase/psdrf/export_dispositif_from_dendro3");
      final response = await Dio()
          .post("$apiBase/psdrf/export_dispositif_from_dendro3", data: data);
      SyncResults syncResults = SyncResults(
        localArbres: SyncDetails(created: 10, updated: 5, deleted: 2),
        distantArbres: SyncDetails(created: 8, updated: 3, deleted: 1),
        localBms: SyncDetails(created: 4, updated: 4, deleted: 0),
        distantBms: SyncDetails(created: 5, updated: 2, deleted: 1),
      );
      if (response.statusCode != 200) {
        throw Failure(message: 'Failed to export data: $response');
      }
      return syncResults;
    } on SocketException catch (err) {
      throw Failure(message: 'Please check your connection. Error: $err');
    } on DioError catch (err) {
      throw Failure(
          message:
              'Failed to export data. Error: ${err.response?.statusMessage}');
    }
  }
}
