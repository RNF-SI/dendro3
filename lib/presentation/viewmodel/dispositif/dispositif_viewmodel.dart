import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/dispositif.dart';
import 'package:dendro3/domain/usecase/actualiser_cycles_dispositif_usecase.dart';
import 'package:dendro3/domain/usecase/export_dispositif_data_usecase.dart';
import 'package:dendro3/domain/usecase/get_dispositif_usecase.dart';
import 'package:dendro3/presentation/model/dispositifInfo.dart';
import 'package:dendro3/presentation/state/state.dart' as custom_async_state;
import 'package:dendro3/presentation/viewmodel/userDispositifs/user_dispositifs_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

final questionsProvider = Provider.autoDispose
    .family<custom_async_state.State<Dispositif>, int>((ref, dispositifId) {
  final dispositifState = ref.watch(dispositifViewModelProvider(dispositifId));

  return dispositifState.when(
    init: () => const custom_async_state.State.init(),
    success: (dispositifInfoList) {
      return custom_async_state.State.success(dispositifInfoList);
    },
    loading: () => const custom_async_state.State.loading(),
    error: (exception) => custom_async_state.State.error(exception),
  );
});

final dispositifViewModelProvider = StateNotifierProvider.autoDispose
    .family<DispositifViewModel, custom_async_state.State<Dispositif>, int>(
        (ref, dispositifId) {
  return DispositifViewModel(
    ref,
    dispositifId,
    ref.watch(getDispositifUseCaseProvider),
    ref.watch(actualiserCyclesDispositifUseCaseProvider),
  );
});

class DispositifViewModel
    extends StateNotifier<custom_async_state.State<Dispositif>> {
  final GetDispositifUseCase _getDispositifUseCase;
  final ActualiserCyclesDispositifUseCase _actualiserCyclesDispositifUseCase;

  DispositifViewModel(
    this.ref,
    int dispositifId,
    this._getDispositifUseCase,
    this._actualiserCyclesDispositifUseCase,
  ) : super(const custom_async_state.State.init()) {
    _init(dispositifId);
  }

  final Ref ref;

  Future<void> _init(int dispositifId) async {
    state = const custom_async_state.State.loading();
    try {
      var dispositif = await _getDispositifUseCase.execute(dispositifId);
      state = custom_async_state.State.success(dispositif);
    } on Exception catch (e) {
      state = custom_async_state.State.error(e);
    } catch (e) {
      print(e);
      state = custom_async_state.State.error(Exception(e));
    }
  }

  deleteDispositif(BuildContext context, VoidCallback onSuccess,
      DispositifInfo dispositifInfo) async {
    try {
      ref
          .read(userDispositifListViewModelStateNotifierProvider.notifier)
          .deleteDispositif(dispositifInfo);

      onSuccess.call();
    } on Exception catch (e) {
      state = custom_async_state.State.error(e);
    } catch (e) {
      print(e);
      state = custom_async_state.State.error(Exception(e));
    }
  }

  actualiserCyclesDispositif(
      BuildContext context, VoidCallback onSuccess, int dispositifId) async {
    try {
      await _actualiserCyclesDispositifUseCase.execute(dispositifId);
      await _init(dispositifId);
      onSuccess.call();
    } on Exception catch (e) {
      state = custom_async_state.State.error(e);
    } catch (e) {
      print(e);
      state = custom_async_state.State.error(Exception(e));
    }
  }
}
