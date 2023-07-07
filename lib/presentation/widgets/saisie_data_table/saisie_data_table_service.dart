import 'package:dendro3/domain/model/arbre_list.dart';
import 'package:dendro3/core/types/saisie_data_table_types.dart';
import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/displayable_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/model/cycle_list.dart';

const columnWidth = 100;

// Provider appelé à la fois pour les toggles bouton et l'affichage dataTable
final reducedToggleProvider =
    StateNotifierProvider.autoDispose<ToggleChangeNotifier, List<bool>>(
  (ref) {
    return ToggleChangeNotifier();
  },
);

final reducedMesureToggleProvider =
    StateNotifierProvider.autoDispose<ToggleChangeNotifier, List<bool>>(
  (ref) {
    return ToggleChangeNotifier();
  },
);

final cycleSelectedToggleProvider =
    StateNotifierProvider.autoDispose<ToggleChangeNotifier, List<bool>>(
  (ref) {
    return ToggleChangeNotifier();
  },
);

class ToggleChangeNotifier extends StateNotifier<List<bool>> {
  ToggleChangeNotifier() : super([]);

  void setToggleList(List<bool> toggleList) {
    state = toggleList;
  }

  void toggleChanged(int index) {
    var stateTemp = state.map((item) => item).toList();
    // var stateTemp = state.copyWith;
    for (int i = 0; i < stateTemp.length; i++) {
      stateTemp[i] = i == index;
    }
    state = stateTemp;
  }

  void cycleToggleChanged(int index) {
    var stateTemp = state.map((item) => item).toList();
    stateTemp[index] = !stateTemp[index];
    state = stateTemp;
  }
}

// Initialisation du reducedMesureToggleProvider
final cycleSelectedProvider =
    StateNotifierProvider.autoDispose<CycleChangeNotifier, List<Cycle>>(
        // We return the default mesureColumn type, here name.
        (ref) {
  return CycleChangeNotifier();
});

class CycleChangeNotifier extends StateNotifier<List<Cycle>> {
  CycleChangeNotifier() : super([]);

  void setCycles(List<Cycle> cycleList) {
    state = cycleList;
  }

  List<bool> convertCyclesToToggles() {
    return state.map<bool>((Cycle cycle) => true).toList();
  }
}

final displayedColumnTypeProvider =
    StateProvider.autoDispose<DisplayedColumnType>(
        // We return the defaul t mesureColumn type, here name.
        (ref) {
  var reducedList = ref.watch(reducedToggleProvider);
  if (reducedList.isNotEmpty) {
    if (reducedList[0] == true) {
      return DisplayedColumnType.all;
    } else if (reducedList[1] == true) {
      return DisplayedColumnType.reduced;
    } else {
      return DisplayedColumnType.none;
    }
  } else {
    return DisplayedColumnType.none;
  }
});

final displayedMesureColumnTypeProvider =
    StateProvider.autoDispose<DisplayedColumnType>(
        // We return the default mesureColumn type, here name.
        (ref) {
  var reducedList = ref.watch(reducedMesureToggleProvider);
  if (reducedList.isNotEmpty) {
    if (reducedList[0] == true) {
      return DisplayedColumnType.all;
    } else if (reducedList[1] == true) {
      return DisplayedColumnType.reduced;
    } else {
      return DisplayedColumnType.none;
    }
  } else {
    return DisplayedColumnType.none;
  }
});

// Permet de récupérer les objets Lisser en fonction
// des columns qu'on veut afficher (boutons)
final rowsProvider = StateProvider.autoDispose
    .family<List<Map<String, dynamic>>, DisplayableList>((ref, itemList) {
  final columnType = ref.watch(displayedColumnTypeProvider);
  final mesureColumnType = ref.watch(displayedMesureColumnTypeProvider);
  var nestedObj = itemList.getObjectMapped(
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
  (ref) {
    List<bool> toggleSelectedList = ref.watch(cycleSelectedToggleProvider);
    List<Cycle> cycleList = ref.watch(cycleSelectedProvider);

    List<int> cycleArray = [];
    for (var i = 0; i < toggleSelectedList.length; i++) {
      if (toggleSelectedList[i]) {
        // Ajouter la valeur du cycle correspondantes aux boutons cliqués
        cycleArray.add(
            cycleList.firstWhere((cycle) => cycle.numCycle == i + 1).idCycle);
      }
    }
    return cycleArray;
  },
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
