import 'package:dendro3/domain/domain_module.dart';
// import 'package:dendro3/domain/model/dispositif_id.dart';
import 'package:dendro3/domain/model/dispositif_list.dart';
// import 'package:dendro3/domain/usecase/create_dispositif_usecase.dart';
// import 'package:dendro3/domain/usecase/delete_dispositif_usecase.dart';
import 'package:dendro3/domain/usecase/get_dispositif_list_from_api_usecase.dart';
// import 'package:dendro3/domain/usecase/update_dispositif_usecase.dart';
import 'package:dendro3/presentation/state/state.dart';
import 'package:dendro3/presentation/viewmodel/dispositiflist/filter_kind_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filteredDispositifListProvider =
    Provider.autoDispose<State<DispositifList>>((ref) {
  final filterKind = ref.watch(filterKindViewModelStateNotifierProvider);
  final dispositifListState =
      ref.watch(dispositifListViewModelStateNotifierProvider);

  return dispositifListState.when(
    init: () => const State.init(),
    success: (dispositifList) {
      switch (filterKind) {
        case FilterKind.all:
          return State.success(dispositifList);
        case FilterKind.downloaded:
          // return State.success(dispositifList.filterByDownloaded());
          return State.success(dispositifList);
        case FilterKind.undownloaded:
          return State.success(dispositifList);
        // return State.success(dispositifList.filterByUndownloaded());
      }
    },
    loading: () => const State.loading(),
    error: (exception) => State.error(exception),
  );
});

final dispositifListViewModelStateNotifierProvider = StateNotifierProvider
    .autoDispose<DispositifListViewModel, State<DispositifList>>((ref) {
  return DispositifListViewModel(
    ref.watch(getDispositifListFromApiUseCaseProvider),
    // ref.watch(createDispositifUseCaseProvider),
    // ref.watch(updateDispositifUseCaseProvider),
    // ref.watch(deleteDispositifUseCaseProvider),
  );
});

class DispositifListViewModel extends StateNotifier<State<DispositifList>> {
  final GetDispositifListFromApiUseCase _getDispositifListFromApiUseCase;
  // final CreateDispositifUseCase _createDispositifUseCase;
  // final UpdateDispositifUseCase _updateDispositifUseCase;
  // final DeleteDispositifUseCase _deleteDispositifUseCase;

  DispositifListViewModel(
    this._getDispositifListFromApiUseCase,
    // this._createDispositifUseCase,
    // this._updateDispositifUseCase,
    // this._deleteDispositifUseCase,
  ) : super(const State.init()) {
    _getDispositifList();
  }

  // completeDispositif(final Dispositif dispositif) {
  //   final newDispositif = dispositif.copyWith(isDownloaded: true);
  //   updateDispositif(newDispositif);
  // }

  // undoDispositif(final Dispositif dispositif) {
  //   final newDispositif = dispositif.copyWith(isDownloaded: false);
  //   updateDispositif(newDispositif);
  // }

  _getDispositifList() async {
    try {
      state = const State.loading();
      final dispositifList = await _getDispositifListFromApiUseCase.execute();
      state = State.success(dispositifList);
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  // addDispositif(
  //   final String title,
  //   final String description,
  //   final bool isCompleted,
  //   final DateTime dueDate,
  // ) async {
  //   try {
  //     final newDispositif = await _createDispositifUseCase.execute(
  //       title,
  //       description,
  //       isCompleted,
  //       dueDate,
  //     );
  //     state = State.success(state.data!.addDispositif(newDispositif));
  //   } on Exception catch (e) {
  //     state = State.error(e);
  //   }
  // }

  // updateDispositif(final Dispositif newDispositif) async {
  //   try {
  //     await _updateDispositifUseCase.execute(
  //       newDispositif.id,
  //       newDispositif.title,
  //       newDispositif.description,
  //       newDispositif.isCompleted,
  //       newDispositif.dueDate,
  //     );
  //     state = State.success(state.data!.updateDispositif(newDispositif));
  //   } on Exception catch (e) {
  //     state = State.error(e);
  //   }
  // }

  // deleteDispositif(final DispositifId id) async {
  //   try {
  //     await _deleteDispositifUseCase.execute(id);
  //     state = State.success(state.data!.removeDispositifById(id));
  //   } on Exception catch (e) {
  //     state = State.error(e);
  //   }
  // }
}
