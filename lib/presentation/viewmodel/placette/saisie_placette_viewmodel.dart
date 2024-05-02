
import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/arbre_list.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/usecase/get_placette_usecase.dart';
import 'package:dendro3/presentation/state/state.dart' as custom_async_state;
import 'package:dendro3/presentation/viewmodel/baseList/arbre_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/baseList/bms_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/baseList/regeneration_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/baseList/repere_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/baseList/transect_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/displayable_list_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// TODO: clean when finished

// import '../../../domain/model/arbre_list.dart';

final saisiePlacetteViewModelProvider = StateNotifierProvider.autoDispose
    .family<SaisiePlacetteViewModel, custom_async_state.State<Placette>, int>(
        (ref, placetteId) {
  return SaisiePlacetteViewModel(
    placetteId,
    ref.watch(getPlacetteUseCaseProvider),
    ref,
  );
});

class SaisiePlacetteViewModel
    extends StateNotifier<custom_async_state.State<Placette>> {
  final GetPlacetteUseCase _getPlacetteUseCase;

  late Placette placette;

  SaisiePlacetteViewModel(int placetteId, this._getPlacetteUseCase, Ref ref)
      : super(const custom_async_state.State.init()) {
    // SaisiePlacetteViewModel(
    //     int placetteId, this._getPlacetteUseCase, this._container)
    //     : super(const custom_async_state.State.init()) {

    _init(ref, placetteId);
  }

  Future<void> _init(Ref ref, int placetteId) async {
    state = const custom_async_state.State.loading();
    try {
      var placette = await _getPlacetteUseCase.execute(placetteId);

      state = custom_async_state.State.success(placette);

      final arbreListViewModel =
          ref.read(arbreListViewModelStateNotifierProvider.notifier);
      arbreListViewModel.setArbreList(placette.arbres!);

      // Initialiser la liste à afficher dans le widget saisie_data_table
      final displayableListNotifier =
          ref.watch(displayableListProvider.notifier);
      displayableListNotifier.setDisplayableList(placette.arbres!);

      final bmsListViewModel =
          ref.read(bmSup30ListViewModelStateNotifierProvider.notifier);
      bmsListViewModel.setBmSup30List(placette.bmsSup30!);

      final transectListViewModel =
          ref.read(transectListViewModelStateNotifierProvider.notifier);
      transectListViewModel
          .setTransectList(placette.corCyclesPlacettes!.allTransects);

      final regenerationListViewModel =
          ref.read(regenerationListViewModelStateNotifierProvider.notifier);
      regenerationListViewModel
          .setRegenerationList(placette.corCyclesPlacettes!.allRegenerations);

      final repereListViewModel =
          ref.read(repereListViewModelStateNotifierProvider.notifier);
      repereListViewModel.setRepereList(placette.reperes!);
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
}
