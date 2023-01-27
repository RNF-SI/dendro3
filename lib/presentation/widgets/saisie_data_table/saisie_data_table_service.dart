import 'package:dendro3/domain/model/arbre_list.dart';
import 'package:dendro3/core/types/saisie_data_table_types.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const columnWidth = 100;

final displayedColumnTypeProvider =
    StateProvider.autoDispose<DisplayedColumnType>(
  // We return the default mesureColumn type, here name.
  (ref) => DisplayedColumnType.all,
);
final displayedMesureColumnTypeProvider =
    StateProvider.autoDispose<DisplayedColumnType>(
  // We return the default mesureColumn type, here name.
  (ref) => DisplayedColumnType.all,
);

// Permet de récupérer les objets Lisser en fonction
// des columns qu'on veut afficher (boutons)
final rowsProvider = StateProvider.autoDispose
    .family<List<Map<String, dynamic>>, ArbreList>((ref, arbreList) {
  final columnType = ref.watch(displayedColumnTypeProvider);
  final mesureColumnType = ref.watch(displayedMesureColumnTypeProvider);
  var nestedObj = arbreList.getObjectMapped(
    displayedColumnType: columnType,
    displayedMesureColumnType: mesureColumnType,
  );
  List<Map<String, dynamic>> objLisseList = [];
  Map<String, dynamic> objLisse = {};
  for (var element in nestedObj) {
    objLisse = {};
    element.forEach((key1, value1) {
      if (value1 is List) {
        for (var mesure in value1) {
          mesure.forEach((key2, value2) {
            objLisse[key2] = value2;
          });
        }
      } else {
        objLisse[key1] = value1;
      }
    });
    objLisseList.add(objLisse);
  }
  return objLisseList;
});

final displayedCycleProvider = StateProvider.autoDispose<List<int>>(
  // We return the default mesureColumn type, here name.
  (ref) => [],
);

final cycleRowsProvider = Provider.autoDispose
    .family<List<Map<String, dynamic>>, List<Map<String, dynamic>>>(
        (ref, list) {
  List<int> rowsCycle = ref.watch(displayedCycleProvider);
  final mesureColumnType =
      ref.read(displayedMesureColumnTypeProvider.notifier).state;

  if (mesureColumnType == DisplayedColumnType.none) {
    return list;
  } else {
    return list.where((item) => rowsCycle.contains(item['idCycle'])).toList();
  }
});

final columnsProvider = Provider.autoDispose
    .family<List<String>, List<Map<String, dynamic>>>((ref, list) {
  return list[0].keys.toList();
});

final arrayWidthProvider =
    Provider.autoDispose.family<double, List<String>>((ref, list) {
  return list.length * columnWidth.toDouble();
});
