import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/usecase/export_database_in_accessible_location_usecase.dart';
import 'package:dendro3/domain/usecase/delete_database_usecase.dart';
import 'package:dendro3/domain/usecase/refresh_nomenclatures_usecase.dart';
import 'package:dendro3/domain/usecase/request_storage_permission_usecase.dart';
import 'package:dendro3/presentation/state/state.dart' as custom_async_state;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final databaseServiceProvider =
    StateNotifierProvider<DatabaseService, custom_async_state.State<void>>(
        (ref) {
  return DatabaseService(
    ref,
    ref.watch(deleteDatabaseUseCaseProvider),
    ref.watch(exportDatabaseInAccessibleLocationUseCaseProvider),
    ref.watch(requestStoragePermissionUseCaseProvider),
    ref.watch(refreshNomenclaturesUseCaseProvider),
  );
});

class DatabaseService extends StateNotifier<custom_async_state.State<void>> {
  final DeleteDatabaseUseCase _deleteDatabaseUseCase;
  final ExportDatabaseInAccessibleLocationUseCase _exportDatabaseUseCase;
  final RequestStoragePermissionUseCase _requestStoragePermissionUseCase;
  final RefreshNomenclaturesUseCase _refreshNomenclaturesUseCase;

  DatabaseService(
    this.ref,
    this._deleteDatabaseUseCase,
    this._exportDatabaseUseCase,
    this._requestStoragePermissionUseCase,
    this._refreshNomenclaturesUseCase,
  ) : super(const custom_async_state.State.init());

  final Ref ref;

  Future<void> deleteDatabase() async {
    state = const custom_async_state.State.loading();
    try {
      await _deleteDatabaseUseCase.execute();
      state = const custom_async_state.State.success(null);
    } on Exception catch (e) {
      state = custom_async_state.State.error(e);
    }
  }

  Future<void> exportDatabase() async {
    state = const custom_async_state.State.loading();
    try {
      await _exportDatabaseUseCase.execute();
      state = const custom_async_state.State.success(null);
    } on Exception catch (e) {
      state = custom_async_state.State.error(e);
    }
  }

  Future<bool> requestStoragePermission() async {
    return await _requestStoragePermissionUseCase.execute();
  }

  Future<void> refreshNomenclatures() async {
    state = const custom_async_state.State.loading();
    try {
      await _refreshNomenclaturesUseCase.execute();
      state = const custom_async_state.State.success(null);
    } on Exception catch (e) {
      state = custom_async_state.State.error(e);
    }
  }
}
