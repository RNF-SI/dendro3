import 'dart:ui';

import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/dispositif.dart';
import 'package:dendro3/domain/usecase/get_user_dispositif_list_from_api_usecase.dart';
import 'package:dendro3/domain/usecase/download_dispositif_data_usecase.dart';
import 'package:dendro3/domain/usecase/get_user_dispositif_list_from_db_usecase.dart';
import 'package:dendro3/domain/usecase/init_local_PSDRF_database_usecase.dart';
import 'package:dendro3/presentation/model/dispositifInfo.dart';
import 'package:dendro3/presentation/model/dispositifInfo_list.dart';
import 'package:dendro3/presentation/state/download_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dendro3/presentation/state/state.dart' as CustomAsyncState;
import 'package:dendro3/domain/model/dispositif_list.dart';

final userDispositifListProvider =
    Provider.autoDispose<CustomAsyncState.State<DispositifInfoList>>((ref) {
  final userDispositifListState =
      ref.watch(userDispositifListViewModelStateNotifierProvider);

  return userDispositifListState.when(
    init: () => const CustomAsyncState.State.init(),
    success: (dispositifInfoList) {
      return CustomAsyncState.State.success(dispositifInfoList);
    },
    loading: () => const CustomAsyncState.State.loading(),
    error: (exception) => CustomAsyncState.State.error(exception),
  );
});

final userDispositifListViewModelStateNotifierProvider =
    StateNotifierProvider.autoDispose<UserDispositifsViewModel,
        CustomAsyncState.State<DispositifInfoList>>((ref) {
  return UserDispositifsViewModel(
    const AsyncValue<DispositifInfoList>.data(DispositifInfoList(values: [])),
    ref.watch(initLocalPSDRFDataBaseUseCaseProvider),
    ref.watch(getUserDispositifListFromAPIUseCaseProvider),
    ref.watch(getUserDispositifListFromDBUseCaseProvider),
    ref.watch(downloadDispositifDataUseCaseProvider),
  );
});

class UserDispositifsViewModel
    extends StateNotifier<CustomAsyncState.State<DispositifInfoList>> {
  final InitLocalPSDRFDataBaseUseCase _initLocalPSDRFDataBaseUseCase;
  final GetUserDispositifListFromAPIUseCase
      _getUserDispositifsListFromAPIUseCase;
  final GetUserDispositifListFromDBUseCase _getUserDispositifsListFromDBUseCase;
  final DownloadDispositifDataUseCase _downloadDispositifDataUseCase;

  UserDispositifsViewModel(
      AsyncValue<DispositifInfoList> userDispList,
      this._initLocalPSDRFDataBaseUseCase,
      this._getUserDispositifsListFromAPIUseCase,
      this._getUserDispositifsListFromDBUseCase,
      this._downloadDispositifDataUseCase)
      : super(const CustomAsyncState.State.init()) {
    _init();
  }

  Future<void> _init() async {
    var dispositifInfoList = const DispositifInfoList(values: []);
    state = const CustomAsyncState.State.loading();
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

        state = CustomAsyncState.State.success(dispositifInfoList);
      } else {
        // Si c'est autre chose, il s'agit d'une erreur(pas internet)
        // On affiche tous les dispositifs en local
        dispositifsList[0].values.asMap().forEach((index, disp0) {
          dispositifInfoList = dispositifInfoList.addDispositifInfo(
              DispositifInfo(
                  dispositif: disp0,
                  downloadStatus: DownloadStatus.downloaded));
        });
        state = CustomAsyncState.State.success(dispositifInfoList);
      }
    } on Exception catch (e) {
      state = CustomAsyncState.State.error(e);
    }
  }

  downloadDispositif(final DispositifInfo dispositifInfo) async {
    final id = dispositifInfo.dispositif.id;
    try {
      var newDispositifInfo =
          dispositifInfo.copyWith(downloadStatus: DownloadStatus.downloading);
      state = CustomAsyncState.State.success(
          state.data!.updateDispositifInfo(newDispositifInfo));
      newDispositifInfo =
          dispositifInfo.copyWith(downloadStatus: DownloadStatus.downloaded);
      await _downloadDispositifDataUseCase.execute(id);
      state = CustomAsyncState.State.success(
          state.data!.updateDispositifInfo(newDispositifInfo));
    } on Exception catch (e) {
      state = CustomAsyncState.State.error(e);
    }
  }

  stopDownloadDispositif(final DispositifInfo dispositifInfo) async {
    if (dispositifInfo.downloadStatus == DownloadStatus.downloading) {
      final newDispositifInfo =
          dispositifInfo.copyWith(downloadStatus: DownloadStatus.downloading);
      state = CustomAsyncState.State.success(
          state.data!.updateDispositifInfo(newDispositifInfo));
    }
  }
}
