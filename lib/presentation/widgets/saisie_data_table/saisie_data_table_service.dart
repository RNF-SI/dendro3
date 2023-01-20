import 'package:dendro3/domain/model/arbre_list.dart';
import 'package:dendro3/core/types/saisie_data_table_types.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const columnWidth = 100;

final displayedColumnTypeProvider = StateProvider<DisplayedColumnType>(
  // We return the default mesureColumn type, here name.
  (ref) => DisplayedColumnType.all,
);
final displayedMesureColumnTypeProvider = StateProvider<DisplayedColumnType>(
  // We return the default mesureColumn type, here name.
  (ref) => DisplayedColumnType.all,
);

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

final columnsProvider = Provider.autoDispose
    .family<List<String>, List<Map<String, dynamic>>>((ref, list) {
  return list[0].keys.toList();
});

final arrayWidthProvider =
    Provider.autoDispose.family<double, List<String>>((ref, list) {
  return list.length * columnWidth.toDouble();
});
