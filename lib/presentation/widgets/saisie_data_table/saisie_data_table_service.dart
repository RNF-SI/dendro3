import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/arbre_list.dart';
import 'package:dendro3/core/types/saisie_data_table_types.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/bmSup30_list.dart';
import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/displayable_list.dart';
import 'package:dendro3/domain/model/regeneration_list.dart';
import 'package:dendro3/domain/model/repere_list.dart';
import 'package:dendro3/domain/model/saisisable_object.dart';
import 'package:dendro3/domain/model/transect_list.dart';
import 'package:dendro3/presentation/viewmodel/displayable_list_notifier.dart';
import 'package:dendro3/presentation/viewmodel/last_modified_Id_notifier.dart';
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
    if (reducedList[1] == true) {
      return DisplayedColumnType.all;
    } else if (reducedList[0] == true) {
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
    if (reducedList[1] == true) {
      return DisplayedColumnType.all;
    } else if (reducedList[0] == true) {
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
    .family<List<Map<String, dynamic>>, dynamic>((ref, objProperties) {
  List<Map<String, dynamic>> rowList = objProperties['rowList'];
  List<Map<String, int>> links = objProperties['links'];

  List<int> rowsCycle = ref.watch(displayedCycleProvider);
  final mesureColumnType =
      ref.read(displayedMesureColumnTypeProvider.notifier).state;

  if (mesureColumnType == DisplayedColumnType.none) {
    return rowList;
  } else if (rowList.isEmpty) {
    return [];
  } else if (rowList[0].containsKey('idArbreOrig') ||
      rowList[0].containsKey('idBmSup30Orig')) {
    return rowList
        .where(
          (item) => rowsCycle.contains(item['idCycle']),
        )
        .toList();
  } else if (rowList[0].containsKey('idTransectOrig') ||
      rowList[0].containsKey('idRegeneration')) {
    var cyclePlacetteToCycleMap = {
      for (var link in links) link['idCyclePlacette']: link['idCycle']
    };

    // Filter the rowList
    List<Map<String, dynamic>> filteredList = rowList.where((row) {
      // Get the cycle ID corresponding to the row's cyclePlacette ID
      var cycleId = cyclePlacetteToCycleMap[row['idCyclePlacette']];

      // Check if this cycleId is in the list of rowsCycle
      return cycleId != null && rowsCycle.contains(cycleId);
    }).toList();

    return filteredList;
  } else {
    return rowList;
  }
});

final columnsProvider = Provider.autoDispose
    .family<List<String>, List<Map<String, dynamic>>>((ref, list) {
  if (list.isEmpty) {
    return [];
  }
  return list[0].keys.toList();
});

final arrayWidthProvider =
    Provider.autoDispose.family<double, List<String>>((ref, list) {
  return list.length * columnWidth.toDouble();
});

class MyParameter {
  Map<String, dynamic> value;
  DisplayableList items;
  // String type;

  MyParameter(this.value, this.items);
}

// final selectedItemProvider =
//     Provider.autoDispose.family<SaisisableObject, MyParameter>((ref, list) {
//   final items = list.items;
//   final type = list.type;
//   final value = list.value;

//   switch (type) {
//     case 'Arbres':
//       return items.getObjectFromId(value['idArbreOrig']);
//     case 'BmsSup30':
//       return items.getObjectFromId(value['idBmSup30Orig']);
//     case 'Regenerations':
//       return items.getObjectFromId(value['idRegeneration']);
//     case 'Repères':
//       return items.getObjectFromId(value['idRepere']);
//     case 'Transects':
//       return items.getObjectFromId(value['idTransectOrig']);
//     default:
//       throw ArgumentError('Unknown type: ${items.runtimeType}');
//   }
// });

final selectedItemDetailsProvider = StateNotifierProvider.autoDispose
    .family<SelectedItemDetailsNotifier, SaisisableObject?, DisplayableList>(
        (ref, items) {
  final lastModifiedProvider = ref.watch(lastModifiedIdProvider.notifier);

  return SelectedItemDetailsNotifier(
    items,
    lastModifiedProvider,
  );
});

class SelectedItemDetailsNotifier extends StateNotifier<SaisisableObject?> {
  final DisplayableList items;
  late final LastModifiedIdNotifier _lastModifiedProvider;

  SelectedItemDetailsNotifier(
    this.items,
    this._lastModifiedProvider,
  ) : super(null) {
    int lastModifiedId;

    // Check if a map is empy
    if (items.isEmpty()) {
      state = null;
      return;
    } else if (_lastModifiedProvider.getObject().isEmpty) {
      lastModifiedId = items.getFirstElementIdOrig();
    } else if (items is ArbreList) {
      lastModifiedId = _lastModifiedProvider.getLastModifiedId('Arbres');
    } else if (items is BmSup30List) {
      lastModifiedId = _lastModifiedProvider.getLastModifiedId('BmsSup30');
    } else if (items is RegenerationList) {
      lastModifiedId = _lastModifiedProvider.getLastModifiedId('Regenerations');
    } else if (items is RepereList) {
      lastModifiedId = _lastModifiedProvider.getLastModifiedId('Repères');
    } else if (items is TransectList) {
      lastModifiedId = _lastModifiedProvider.getLastModifiedId('Transects');
    } else {
      throw ArgumentError('Unknown type: ${items.runtimeType}');
    }

    state = items.getObjectFromId(lastModifiedId);
  }

  SaisisableObject? setSelectedItemDetails(
      Map<String, dynamic> value, String type) {
    switch (type) {
      case 'Arbres':
        state = items.getObjectFromId(value['idArbreOrig']);
        return state;
      case 'BmsSup30':
        state = items.getObjectFromId(value['idBmSup30Orig']);
        return state;
      case 'Regenerations':
        state = items.getObjectFromId(value['idRegeneration']);
        return state;
      case 'Repères':
        state = items.getObjectFromId(value['idRepere']);
        return state;
      case 'Transects':
        state = items.getObjectFromId(value['idTransectOrig']);
        return state;
      default:
        throw ArgumentError('Unknown type: ${items.runtimeType}');
    }
  }
}

final selectedItemMesureDetailsProvider = StateNotifierProvider.autoDispose
    .family<SelectedItemMesureDetailsNotifier, SaisisableObject?,
        SaisisableObject?>((ref, item) {
  return SelectedItemMesureDetailsNotifier(item);
});

class SelectedItemMesureDetailsNotifier
    extends StateNotifier<SaisisableObject?> {
  final SaisisableObject? item;

  SelectedItemMesureDetailsNotifier(this.item) : super(null) {
    if (item is Arbre) {
      Arbre arbreDetails = item as Arbre;
      state = arbreDetails.arbresMesures!.values.first;
    } else if (item is BmSup30) {
      BmSup30 bmSup30Details = item as BmSup30;
      state = bmSup30Details.bmsSup30Mesures!.values.first;
    } else {
      state = null;
    }
  }

  void setSelectedItemMesureDetails(int selectedIndex) {
    if (item is Arbre) {
      Arbre arbreDetails = item as Arbre;
      state = arbreDetails.arbresMesures!.values[selectedIndex];
    } else if (item is BmSup30) {
      BmSup30 bmSup30Details = item as BmSup30;
      state = bmSup30Details.bmsSup30Mesures!.values[selectedIndex];
      // } else if (item is Regeneration) {
      //   Regeneration regenerationDetails = item as Regeneration;
      //   state = regenerationDetails.regenerationsMesures!.values[selectedIndex];
      // } else if (item is Repere) {
      //   Repere repereDetails = item as Repere;
      //   state = repereDetails.reperesMesures!.values[selectedIndex];
      // } else if (item is Transect) {
      //   Transect transectDetails = item as Transect;
      //   state = transectDetails.transectsMesures!.values[selectedIndex];
    } else {
      state = null;
      // throw ArgumentError('Unknown type: ${item.runtimeType}');
    }
    // case 'BmsSup30':
    //   state = item.getObjectFromId(value['idBmSup30Orig']);
    //   break;
    // case 'Regenerations':
    //   state = item.getObjectFromId(value['idRegeneration']);
    //   break;
    // case 'Repères':
    //   state = item.getObjectFromId(value['idRepere']);
    //   break;
    // case 'Transects':
    //   state = item.getObjectFromId(value['idTransectOrig']);
    //   break;
  }
}
