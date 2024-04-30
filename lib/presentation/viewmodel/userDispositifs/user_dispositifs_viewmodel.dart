import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/dispositif_list.dart';
import 'package:dendro3/domain/usecase/delete_dispositif_usecase.dart';
import 'package:dendro3/domain/usecase/get_user_dispositif_list_from_api_usecase.dart';
import 'package:dendro3/domain/usecase/download_dispositif_data_usecase.dart';
import 'package:dendro3/domain/usecase/get_user_dispositif_list_from_db_usecase.dart';
import 'package:dendro3/domain/usecase/get_user_id_from_local_storage_use_case.dart';
import 'package:dendro3/domain/usecase/init_local_PSDRF_database_usecase.dart';
import 'package:dendro3/presentation/model/dispositifInfo.dart';
import 'package:dendro3/presentation/model/dispositifInfo_list.dart';
import 'package:dendro3/presentation/state/download_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dendro3/presentation/state/state.dart' as custom_async_state;
import 'package:connectivity_plus/connectivity_plus.dart';

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
    ref.watch(getUserIdFromLocalStorageUseCaseProvider),
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
  final GetUserIdFromLocalStorageUseCase _getUserIdFromLocalStorageUseCase;

  UserDispositifsViewModel(
    AsyncValue<DispositifInfoList> userDispList,
    this._initLocalPSDRFDataBaseUseCase,
    this._getUserDispositifsListFromAPIUseCase,
    this._getUserDispositifsListFromDBUseCase,
    this._downloadDispositifDataUseCase,
    this._deleteDispositifUseCase,
    this._getUserIdFromLocalStorageUseCase,
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

  Future<void> refreshDispositifs() async {
    _init();
  }

  Future<void> _init() async {
    state = const custom_async_state.State.loading();

    bool isConnected = await hasInternetConnection(); // Implement this function
    List<DispositifInfo> finalDispositifs = [];
    Set<int> dbIDs = Set();

    // get userId in the local storage
    final userId = await _getUserIdFromLocalStorageUseCase.execute();

    // Always fetch from DB first to determine downloaded status
    var dbDispositifs =
        await _getUserDispositifsListFromDBUseCase.execute(userId);
    for (var dbDisp in dbDispositifs.values) {
      // Add all DB dispositifs as downloaded
      finalDispositifs.add(DispositifInfo(
          dispositif: dbDisp, downloadStatus: DownloadStatus.downloaded));
      dbIDs.add(dbDisp.id); // Keep track of downloaded IDs
    }

    if (isConnected) {
      try {
        // Fetch dispositifs from API
        var apiDispositifs =
            await _getUserDispositifsListFromAPIUseCase.execute(userId);
        for (var apiDisp in apiDispositifs.values) {
          if (!dbIDs.contains(apiDisp.id)) {
            // If not in DB, mark as not downloaded
            finalDispositifs.add(DispositifInfo(
                dispositif: apiDisp,
                downloadStatus: DownloadStatus.notDownloaded));
          }
          // If it's in DB, it's already added as downloaded, no action needed
        }
      } catch (e) {
        print("Error fetching from API: $e");
        // Optionally handle the error, such as logging or setting a state to show an error message
      }
    }

    state = custom_async_state.State.success(
        DispositifInfoList(values: finalDispositifs));
  }

  Future<bool> hasInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // We have a network connection, so we might have internet
      // Note: This does not guarantee internet access, further checking is needed for actual internet access
      return true;
    }
    return false;
  }

  downloadDispositif(final DispositifInfo dispositifInfo, context) async {
    final id = dispositifInfo.dispositif.id;
    bool isConnected = await hasInternetConnection();
    if (!isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text("Téléchargement impossible: Connexion internet indisponible."),
      ));
    } else {
      // Internet connection is available, proceed with the download
      try {
        var newDispositifInfo =
            dispositifInfo.copyWith(downloadStatus: DownloadStatus.downloading);
        state = custom_async_state.State.success(
            state.data!.updateDispositifInfo(newDispositifInfo));
        await _downloadDispositifDataUseCase.execute(id);
        newDispositifInfo =
            dispositifInfo.copyWith(downloadStatus: DownloadStatus.downloaded);
        state = custom_async_state.State.success(
            state.data!.updateDispositifInfo(newDispositifInfo));
      } on Exception catch (e) {
        state = custom_async_state.State.error(e);
      } catch (e) {
        print(e);
        state = custom_async_state.State.error(Exception(e));
      }
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
