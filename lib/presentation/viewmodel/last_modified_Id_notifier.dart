import 'package:flutter_riverpod/flutter_riverpod.dart';

class LastModifiedIds {
  final Map<String, int?> ids;

  LastModifiedIds({required this.ids});

  int? getIdForType(String type) => ids[type];

  LastModifiedIds updateId(String type, int? id) {
    return LastModifiedIds(ids: Map.from(ids)..[type] = id);
  }
}

final lastModifiedIdProvider =
    StateNotifierProvider<LastModifiedIdNotifier, LastModifiedIds>(
  (ref) => LastModifiedIdNotifier(),
);

class LastModifiedIdNotifier extends StateNotifier<LastModifiedIds> {
  LastModifiedIdNotifier() : super(LastModifiedIds(ids: {}));

  void setLastModifiedId(String type, int? id) {
    state = state.updateId(type, id);
  }

  getLastModifiedId(String type) => state.getIdForType(type);

  getObject() => state.ids;
}
