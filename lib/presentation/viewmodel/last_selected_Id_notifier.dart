import 'package:flutter_riverpod/flutter_riverpod.dart';

class LastSelectedIds {
  final Map<String, int?> ids;

  LastSelectedIds({required this.ids});

  int? getIdForType(String type) => ids[type];

  LastSelectedIds updateId(String type, int? id) {
    return LastSelectedIds(ids: Map.from(ids)..[type] = id);
  }
}

final lastSelectedIdProvider =
    StateNotifierProvider<LastSelectedIdNotifier, LastSelectedIds>(
  (ref) => LastSelectedIdNotifier(),
);

class LastSelectedIdNotifier extends StateNotifier<LastSelectedIds> {
  LastSelectedIdNotifier() : super(LastSelectedIds(ids: {}));

  void setLastSelectedId(String type, int? id) {
    state = state.updateId(type, id);
  }

  getLastSelectedId(String type) => state.getIdForType(type);

  getObject() => state.ids;
}
