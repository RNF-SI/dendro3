import 'dart:io';

import 'package:dendro3/core/error/failure.dart';
import 'package:dendro3/core/helpers/sync_objects.dart';
import 'package:dendro3/data/datasource/interface/api/dispositifs_api.dart';
import 'package:dendro3/data/entity/dispositifs_entity.dart';
import 'package:dendro3/config/config.dart';
import 'package:dio/dio.dart';

class DispositifsApiImpl implements DispositifsApi {
  final String apiBase = Config.apiBase;

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

  // @override
  // Future<DispositifEntity> getDispositifFromId(final int dispId) async {
  //   Response response =
  //       await Dio().get("$apiBase/psdrf/dispositif-complet/$dispId");
  //   DispositifEntity dispEnt = {};
  //   response.data.forEach((k, v) => {dispEnt[k] = v});
  //   return dispEnt;
  // }

  Future<DispositifEntity> getDispositifFromId(
      final int dispId, Function(double) onProgressUpdate) async {
    final url = "$apiBase/psdrf/dispositif-complet/$dispId";
    try {
      final response = await Dio().get(url);
      if (response.statusCode == 202) {
        final taskId = response.data['task_id'];
        return pollTaskForDispositif(taskId, onProgressUpdate);
      } else {
        throw Exception('Failed to initiate task: ${response.statusCode}');
      }
    } on DioException catch (err) {
      throw Exception(
          'Error retrieving dispositif: ${err.response?.statusMessage}');
    }
  }

  Future<DispositifEntity> pollTaskForDispositif(
      String taskId, Function(double) onProgressUpdate) async {
    final statusUrl = "$apiBase/psdrf/dispositif-complet/status/$taskId";
    double progress = 0.0;
    const int maxSteps = 120;
    int currentStep = 0;

    while (true) {
      final statusResponse = await Dio().get(statusUrl);
      if (statusResponse.statusCode == 200 &&
          statusResponse.data['state'] == 'SUCCESS') {
        onProgressUpdate(1.0); // Full progress when completed
        return fetchDispositifResult(taskId);
      } else if (statusResponse.data['state'] == 'FAILURE') {
        throw Exception(
            'Task failed with error: ${statusResponse.data['status']}');
      } else if (statusResponse.statusCode == 202) {
        progress = currentStep / maxSteps;
        progress = progress < 1.0
            ? progress
            : 0.95; // Never reach full progress unless completed
        onProgressUpdate(progress);
        currentStep++;
      } else {
        throw Exception(
            'Unexpected response status: ${statusResponse.statusCode}');
      }
      await Future.delayed(Duration(seconds: 20)); // Wait before polling again
    }
  }

  Future<DispositifEntity> fetchDispositifResult(String taskId) async {
    final resultUrl = "$apiBase/psdrf/dispositif-complet/result/$taskId";
    final resultResponse = await Dio().get(resultUrl);
    if (resultResponse.statusCode == 200) {
      DispositifEntity dispEnt = {};
      resultResponse.data.forEach((k, v) => {dispEnt[k] = v});
      return dispEnt;
    } else {
      throw Exception(
          'Failed to fetch dispositif result: ${resultResponse.statusCode}');
    }
  }

  @override
  Future<TaskResult> exportDispositifData(DispositifEntity data) async {
    final dio =
        Dio(); // Consider creating Dio instance outside of method if called frequently

    dio.options
      ..sendTimeout = const Duration(
          minutes: 3) // Shorter send timeout, since you're just sending data
      ..receiveTimeout =
          const Duration(minutes: 3) // Polling should not take long
      ..connectTimeout = const Duration(minutes: 1);

    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: true,
    ));

    final url = "$apiBase/psdrf/export_dispositif_from_dendro3";
    try {
      final response = await dio.post(url, data: data);
      print(response);
      if (response.statusCode == 202) {
        final taskId = response.data['task_id'];
        return pollTaskStatus(taskId);
      } else {
        throw Exception(
            'Failed to initiate export task: ${response.statusCode}');
      }
    } on DioException catch (err) {
      throw Exception(
          'Failed to export data. Error: ${err.response?.statusMessage}');
    }
  }

  Future<TaskResult> pollTaskStatus(String taskId) async {
    final dio = Dio(); // Reuse Dio instance if possible
    final statusUrl =
        "$apiBase/psdrf/export_dispositif_from_dendro3/status/$taskId";

    while (true) {
      final statusResponse = await dio.get(statusUrl);
      if (statusResponse.statusCode == 200 &&
          statusResponse.data['state'] == 'SUCCESS') {
        return fetchTaskResult(taskId);
      } else if (statusResponse.data['state'] == 'FAILURE') {
        throw Exception(
            'Task failed with error: ${statusResponse.data['status']}');
      } else if (statusResponse.statusCode == 202) {
        // Task is still processing, continue polling
        print('Task is still processing, waiting to retry...');
      } else {
        // Handle unexpected response status
        throw Exception(
            'Unexpected response status: ${statusResponse.statusCode}');
      }

      await Future.delayed(Duration(seconds: 20)); // Wait before polling again
    }
  }

  Future<TaskResult> fetchTaskResult(String taskId) async {
    final dio = Dio(); // Reuse Dio instance if possible
    final resultUrl =
        "$apiBase/psdrf/export_dispositif_from_dendro3/result/$taskId";
    final resultResponse = await dio.get(resultUrl);

    if (resultResponse.statusCode == 200) {
      final result = resultResponse.data['data'];
      // Parse your result here and create SyncResults
      // Assuming result is a Map and directly contains the counts
      SyncResults syncResults = SyncResults(
        distantArbres: SyncDetails(
          created: result['counts_arbre']['created'] ?? 0,
          updated: result['counts_arbre']['updated'] ?? 0,
          deleted: result['counts_arbre']['deleted'] ?? 0,
        ),
        localArbres: SyncDetails(created: 0, updated: 0, deleted: 0),
        distantArbresMesures: SyncDetails(
          created: result['counts_arbre_mesure']['created'] ?? 0,
          updated: result['counts_arbre_mesure']['updated'] ?? 0,
          deleted: result['counts_arbre_mesure']['deleted'] ?? 0,
        ),
        localArbresMesures: SyncDetails(created: 0, updated: 0, deleted: 0),
        distantBms: SyncDetails(
          created: result['counts_bm']['created'] ?? 0,
          updated: result['counts_bm']['updated'] ?? 0,
          deleted: result['counts_bm']['deleted'] ?? 0,
        ),
        localBms: SyncDetails(created: 0, updated: 0, deleted: 0),
        distantBmsMesures: SyncDetails(
          created: result['counts_bm_mesure']['created'] ?? 0,
          updated: result['counts_bm_mesure']['updated'] ?? 0,
          deleted: result['counts_bm_mesure']['deleted'] ?? 0,
        ),
        localBmsMesures: SyncDetails(created: 0, updated: 0, deleted: 0),
        distantReperes: SyncDetails(
          created: result['counts_repere']['created'] ?? 0,
          updated: result['counts_repere']['updated'] ?? 0,
          deleted: result['counts_repere']['deleted'] ?? 0,
        ),
        localReperes: SyncDetails(created: 0, updated: 0, deleted: 0),
        distantCorCyclesPlacettes: SyncDetails(
          created: result['counts_cor_cycle_placette']['created'] ?? 0,
          updated: result['counts_cor_cycle_placette']['updated'] ?? 0,
          deleted: result['counts_cor_cycle_placette']['deleted'] ?? 0,
        ),
        localCorCyclesPlacettes:
            SyncDetails(created: 0, updated: 0, deleted: 0),
        distantRegenerations: SyncDetails(
          created: result['counts_regeneration']['created'] ?? 0,
          updated: result['counts_regeneration']['updated'] ?? 0,
          deleted: result['counts_regeneration']['deleted'] ?? 0,
        ),
        localRegenerations: SyncDetails(created: 0, updated: 0, deleted: 0),
        distantTransects: SyncDetails(
          created: result['counts_transect']['created'] ?? 0,
          updated: result['counts_transect']['updated'] ?? 0,
          deleted: result['counts_transect']['deleted'] ?? 0,
        ),
        localTransects: SyncDetails(created: 0, updated: 0, deleted: 0),
      );

      // Create a new type containing SyncResults and created_arbres
      return TaskResult(
        syncResults: syncResults,
        createdArbres: (result['created_arbres'] as List)
            .map((item) => item as Map<String, dynamic>)
            .toList(),
        createdBms: (result['created_bms'] as List)
            .map((item) => item as Map<String, dynamic>)
            .toList(),
      );
    } else {
      throw Exception('Failed to fetch results: ${resultResponse.statusCode}');
    }
  }
}
