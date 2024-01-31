import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/usecase/delete_database_usecase.dart';
import 'package:dendro3/presentation/state/state.dart' as custom_async_state;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final databaseServiceProvider = Provider.autoDispose<DatabaseService>((ref) {
  return DatabaseService(
    ref,
    ref.watch(deleteDatabaseUseCaseProvider),
  );
});

class DatabaseService extends StateNotifier<custom_async_state.State<void>> {
  final DeleteDatabaseUseCase _deleteDatabaseUseCase;

  DatabaseService(
    this.ref,
    this._deleteDatabaseUseCase,
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
}
