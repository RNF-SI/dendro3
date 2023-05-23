import 'dart:ui';

import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/arbre_list.dart';
import 'package:dendro3/domain/model/dispositif.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/usecase/delete_dispositif_usecase.dart';
import 'package:dendro3/domain/usecase/get_dispositif_usecase.dart';
import 'package:dendro3/domain/usecase/get_placette_usecase.dart';
import 'package:dendro3/presentation/state/state.dart' as custom_async_state;
import 'package:dendro3/presentation/viewmodel/arbrelist/arbre_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// TODO: clean when finished

// import '../../../domain/model/arbre_list.dart';

// final saisiePlacetteViewModelProvider = StateNotifierProvider.autoDispose
//     .family<SaisiePlacetteViewModel, custom_async_state.State<Placette>, int>(
//         (ref, placetteId) {
//   return SaisiePlacetteViewModel(
//     placetteId,
//     ref.watch(getPlacetteUseCaseProvider),
//   );
// });

final saisiePlacetteViewModelProvider = StateNotifierProvider.autoDispose
    .family<SaisiePlacetteViewModel, custom_async_state.State<Placette>, int>(
        (ref, placetteId) {
  final container = ref.container;
  return SaisiePlacetteViewModel(
    placetteId,
    ref.watch(getPlacetteUseCaseProvider),
    container,
  );
});

class SaisiePlacetteViewModel
    extends StateNotifier<custom_async_state.State<Placette>> {
  final GetPlacetteUseCase _getPlacetteUseCase;
  final ProviderContainer _container;
  // late ArbreList arbreListe;
  late Placette placette;

  SaisiePlacetteViewModel(
      int placetteId, this._getPlacetteUseCase, this._container)
      : super(const custom_async_state.State.init()) {
    // SaisiePlacetteViewModel(
    //     int placetteId, this._getPlacetteUseCase, this._container)
    //     : super(const custom_async_state.State.init()) {

    // var arbreListStateNotifier = _ref.read(arbreListViewModelStateNotifierProvider);
    //     arbreListStateNotifier.addListener((state) {
    //   // Handle ArbreList updates here
    // });

    // final arbreListStateNotifier =
    //     _container.read(arbreListViewModelStateNotifierProvider.notifier);
    // arbreListStateNotifier.addListener((state) {
    //   // Gérer les mises à jour d'ArbreList ici
    //   _handleArbreListUpdates(state);
    // });

    // final arbreListStateNotifier = _ref.watch(arbreListViewModelStateNotifierProvider.notifier);
    // arbreListStateNotifier.addListener((state) {
    //   // Handle ArbreList updates here
    // });

    _init(placetteId);
  }

  Future<void> _init(int placetteId) async {
    state = const custom_async_state.State.loading();
    try {
      var placette = await _getPlacetteUseCase.execute(placetteId);

      // arbreListe = placette.arbres;

      state = custom_async_state.State.success(placette);
    } on Exception catch (e) {
      state = custom_async_state.State.error(e);
    } catch (e) {
      print(e);
    }
  }

  void _handleArbreListUpdates(
      custom_async_state.State<ArbreList> arbreListState) {
    print('haah');

    // Mettez à jour SaisiePlacetteViewModel en fonction des changements d'ArbreList
    // Vous pouvez accéder à la nouvelle valeur d'ArbreList avec "arbreListState.data"
  }

  Placette getPlacetteState() {
    return placette;
  }

  // ArbreList getArbreList() {
  //   if (placette.arbres == null) {
  //     return [];
  //   } else {
  //     return placette.arbres;
  //   }
  // }
  // ArbreList getArbreListState() {
  //   final arbreListStateNotifier =
  //       _container.read(arbreListViewModelStateNotifierProvider.notifier);
  //   return arbreListStateNotifier.state;
  // }
}
