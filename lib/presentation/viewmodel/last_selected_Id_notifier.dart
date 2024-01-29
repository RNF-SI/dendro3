import 'package:flutter_riverpod/flutter_riverpod.dart';

class LastSelectedIds {
  final Map<String, String?> ids;

  LastSelectedIds({required this.ids});

  String? getIdForType(String type) => ids[type];

  LastSelectedIds updateId(String type, String? id) {
    return LastSelectedIds(ids: Map.from(ids)..[type] = id);
  }
}

final lastSelectedIdProvider =
    StateNotifierProvider<LastSelectedIdNotifier, LastSelectedIds>(
  (ref) => LastSelectedIdNotifier(),
);

class LastSelectedIdNotifier extends StateNotifier<LastSelectedIds> {
  LastSelectedIdNotifier() : super(LastSelectedIds(ids: {}));

  void setLastSelectedId(String type, String? id) {
    state = state.updateId(type, id);
  }

  getLastSelectedId(String type) => state.getIdForType(type);

  // reset all selected ids
  void reset() {
    state = LastSelectedIds(ids: {});
  }

  getObject() => state.ids;
}
