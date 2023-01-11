import 'dart:ui';

import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/dispositif.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/usecase/delete_dispositif_usecase.dart';
import 'package:dendro3/domain/usecase/get_dispositif_usecase.dart';
import 'package:dendro3/domain/usecase/get_placette_usecase.dart';
import 'package:dendro3/presentation/state/state.dart' as custom_async_state;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final saisiePlacetteViewModelProvider = StateNotifierProvider.autoDispose
    .family<SaisiePlacetteViewModel, custom_async_state.State<Placette>, int>(
        (ref, placetteId) {
  return SaisiePlacetteViewModel(
    placetteId,
    ref.watch(getPlacetteUseCaseProvider),
  );
});

class SaisiePlacetteViewModel
    extends StateNotifier<custom_async_state.State<Placette>> {
  final GetPlacetteUseCase _getPlacetteUseCase;

  SaisiePlacetteViewModel(
    int placetteId,
    this._getPlacetteUseCase,
  ) : super(const custom_async_state.State.init()) {
    _init(placetteId);
  }

  Future<void> _init(int placetteId) async {
    state = const custom_async_state.State.loading();
    try {
      var placette = await _getPlacetteUseCase.execute(placetteId);
      state = custom_async_state.State.success(placette);
    } on Exception catch (e) {
      state = custom_async_state.State.error(e);
    } catch (e) {
      print(e);
    }
  }
}
