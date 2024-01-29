import 'dart:ui';

import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/dispositif.dart';
import 'package:dendro3/domain/usecase/delete_dispositif_usecase.dart';
import 'package:dendro3/domain/usecase/get_user_dispositif_list_from_api_usecase.dart';
import 'package:dendro3/domain/usecase/download_dispositif_data_usecase.dart';
import 'package:dendro3/domain/usecase/get_user_dispositif_list_from_db_usecase.dart';
import 'package:dendro3/domain/usecase/init_local_PSDRF_database_usecase.dart';
import 'package:dendro3/presentation/model/dispositifInfo.dart';
import 'package:dendro3/presentation/model/dispositifInfo_list.dart';
import 'package:dendro3/presentation/state/download_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dendro3/presentation/state/state.dart' as custom_async_state;
import 'package:dendro3/domain/model/dispositif_list.dart';

final userDispositifListProvider =
    Provider.autoDispose<custom_async_state.State<DispositifInfoList>>((ref) {
  final userDispositifListState =
      ref.watch(userDispositifListViewModelStateNotifierProvider);

  return userDispositifListState.when(
    init: () => const custom_async_state.State.init(),
    success: (dispositifInfoList) {
      return custom_async_state.State.success(dispositifInfoList);
    },
    loading: () => const custom_async_state.State.loading(),
    error: (exception) => custom_async_state.State.error(exception),
  );
});

final userDispositifListViewModelStateNotifierProvider =
    StateNotifierProvider.autoDispose<UserDispositifsViewModel,
        custom_async_state.State<DispositifInfoList>>((ref) {
  return UserDispositifsViewModel(
    const AsyncValue<DispositifInfoList>.data(DispositifInfoList(values: [])),
    ref.watch(initLocalPSDRFDataBaseUseCaseProvider),
    ref.watch(getUserDispositifListFromAPIUseCaseProvider),
    ref.watch(getUserDispositifListFromDBUseCaseProvider),
    ref.watch(downloadDispositifDataUseCaseProvider),
    ref.watch(deleteDispositifUseCaseProvider),
  );
});

class UserDispositifsViewModel
    extends StateNotifier<custom_async_state.State<DispositifInfoList>> {
  final InitLocalPSDRFDataBaseUseCase _initLocalPSDRFDataBaseUseCase;
  final GetUserDispositifListFromAPIUseCase
      _getUserDispositifsListFromAPIUseCase;
  final GetUserDispositifListFromDBUseCase _getUserDispositifsListFromDBUseCase;
  final DownloadDispositifDataUseCase _downloadDispositifDataUseCase;
  final DeleteDispositifUseCase _deleteDispositifUseCase;

  UserDispositifsViewModel(
    AsyncValue<DispositifInfoList> userDispList,
    this._initLocalPSDRFDataBaseUseCase,
    this._getUserDispositifsListFromAPIUseCase,
    this._getUserDispositifsListFromDBUseCase,
    this._downloadDispositifDataUseCase,
    this._deleteDispositifUseCase,
  ) : super(const custom_async_state.State.init()) {
    _init();
    // Creates db tables and insert liste data (ex:essences, etc.)
    try {
      _initLocalPSDRFDataBaseUseCase.execute();
    } on Exception catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _init() async {
    var dispositifInfoList = const DispositifInfoList(values: []);
    state = const custom_async_state.State.loading();
    try {
      var dispositifsList = await Future.wait([
        _getUserDispositifsListFromAPIUseCase.execute(3),
        _getUserDispositifsListFromDBUseCase.execute(3)
      ]);
      // Si c'est une liste, alors on a bien une connexion internet
      // On affiche tous les dispositif
      if (dispositifsList[0].values is List) {
        var downloadStatus = DownloadStatus.notDownloaded;
        dispositifsList[0].values.asMap().forEach((index, disp0) {
          downloadStatus = DownloadStatus.notDownloaded;
          dispositifsList[1].values.asMap().forEach((index, disp1) => {
                if (disp0.id == disp1.id)
                  {downloadStatus = DownloadStatus.downloaded}
              });
          dispositifInfoList = dispositifInfoList.addDispositifInfo(
              DispositifInfo(
                  dispositif: disp0, downloadStatus: downloadStatus));
        });

        state = custom_async_state.State.success(dispositifInfoList);
      } else {
        // Si c'est autre chose, il s'agit d'une erreur(pas internet)
        // On affiche tous les dispositifs en local
        dispositifsList[0].values.asMap().forEach((index, disp0) {
          dispositifInfoList = dispositifInfoList.addDispositifInfo(
              DispositifInfo(
                  dispositif: disp0,
                  downloadStatus: DownloadStatus.downloaded));
        });
        state = custom_async_state.State.success(dispositifInfoList);
      }
    } on Exception catch (e) {
      state = custom_async_state.State.error(e);
    } catch (e) {
      print(e);
      state = custom_async_state.State.error(Exception(e));
    }
  }

  downloadDispositif(final DispositifInfo dispositifInfo) async {
    final id = dispositifInfo.dispositif.id;
    try {
      var newDispositifInfo =
          dispositifInfo.copyWith(downloadStatus: DownloadStatus.downloading);
      state = custom_async_state.State.success(
          state.data!.updateDispositifInfo(newDispositifInfo));
      newDispositifInfo =
          dispositifInfo.copyWith(downloadStatus: DownloadStatus.downloaded);
      await _downloadDispositifDataUseCase.execute(id);
      state = custom_async_state.State.success(
          state.data!.updateDispositifInfo(newDispositifInfo));
    } on Exception catch (e) {
      state = custom_async_state.State.error(e);
    } catch (e) {
      print(e);
      state = custom_async_state.State.error(Exception(e));
    }
  }

  stopDownloadDispositif(final DispositifInfo dispositifInfo) async {
    if (dispositifInfo.downloadStatus == DownloadStatus.downloading) {
      final newDispositifInfo =
          dispositifInfo.copyWith(downloadStatus: DownloadStatus.downloading);
      state = custom_async_state.State.success(
          state.data!.updateDispositifInfo(newDispositifInfo));
    }
  }

  deleteDispositif(final DispositifInfo dispositifInfo) async {
    try {
      if (dispositifInfo.downloadStatus == DownloadStatus.downloaded) {
        // Update the status to 'removing' before starting the deletion
        final removingDispositifInfo =
            dispositifInfo.copyWith(downloadStatus: DownloadStatus.removing);
        state = custom_async_state.State.success(
            state.data!.updateDispositifInfo(removingDispositifInfo));

        // Perform the deletion
        await _deleteDispositifUseCase.execute(dispositifInfo.dispositif.id);

        // Update the status back to 'notDownloaded' after deletion is complete
        final newDispositifInfo = dispositifInfo.copyWith(
            downloadStatus: DownloadStatus.notDownloaded);
        state = custom_async_state.State.success(
            state.data!.updateDispositifInfo(newDispositifInfo));
      }
    } on Exception catch (e) {
      state = custom_async_state.State.error(e);
    } catch (e) {
      print(e);
      state = custom_async_state.State.error(Exception(e));
    }
  }
}
