import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/arbre_list.dart';
import 'package:dendro3/core/types/saisie_data_table_types.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/bmSup30_list.dart';
import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/displayable_list.dart';
import 'package:dendro3/domain/model/regeneration.dart';
import 'package:dendro3/domain/model/regeneration_list.dart';
import 'package:dendro3/domain/model/repere.dart';
import 'package:dendro3/domain/model/repere_list.dart';
import 'package:dendro3/domain/model/saisisable_object.dart';
import 'package:dendro3/domain/model/transect.dart';
import 'package:dendro3/domain/model/transect_list.dart';
import 'package:dendro3/presentation/viewmodel/displayable_list_notifier.dart';
import 'package:dendro3/presentation/viewmodel/last_selected_Id_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/model/cycle_list.dart';

const columnWidth = 80;

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
final rowsProvider =
    StateProvider.autoDispose<List<Map<String, dynamic>>>((ref) {
  DisplayableList itemList = ref.watch(displayableListProvider);
  final columnType = ref.watch(displayedColumnTypeProvider);
  final mesureColumnType = ref.watch(displayedMesureColumnTypeProvider);
  var nestedObj = itemList.getObjectMapped(
    displayedColumnType: columnType,
    displayedMesureColumnType: mesureColumnType,
  );
  List<Map<String, dynamic>> objLisseList = [];
  Map<String, dynamic> objLisse = {};
  return flattenNestedObject(nestedObj);
});

List<Map<String, dynamic>> flattenNestedObject(
    List<Map<String, dynamic>> nestedObj) {
  List<Map<String, dynamic>> flattenedList = [];

  for (var element in nestedObj) {
    bool hasNestedList = false;

    // Handling 'arbresMesures'
    if (element.containsKey('arbresMesures') &&
        element['arbresMesures'] is List) {
      hasNestedList = true;
      Map<String, dynamic> topLevelAttributes = Map.from(element)
        ..remove('arbresMesures');

      for (var mesure in element['arbresMesures']) {
        Map<String, dynamic> combinedMap = Map.from(topLevelAttributes);
        mesure.forEach((key, value) {
          combinedMap[key] = value;
        });
        flattenedList.add(combinedMap);
      }
    }

    // Handling 'bmsSup30Mesures'
    if (element.containsKey('bmsSup30Mesures') &&
        element['bmsSup30Mesures'] is List) {
      hasNestedList = true;
      Map<String, dynamic> topLevelAttributes = Map.from(element)
        ..remove('bmsSup30Mesures');

      for (var mesure in element['bmsSup30Mesures']) {
        Map<String, dynamic> combinedMap = Map.from(topLevelAttributes);
        mesure.forEach((key, value) {
          combinedMap[key] = value;
        });
        flattenedList.add(combinedMap);
      }
    }

    if (!hasNestedList) {
      flattenedList.add(element);
    }
  }

  return flattenedList;
}

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

// Provider for idCyclePlacetteIdCycleMapList
final idCyclePlacetteIdCycleMapListProvider = StateNotifierProvider<
    IdCyclePlacetteIdCycleMapListNotifier, List<Map<String, dynamic>>>((ref) {
  return IdCyclePlacetteIdCycleMapListNotifier();
});

class IdCyclePlacetteIdCycleMapListNotifier
    extends StateNotifier<List<Map<String, dynamic>>> {
  IdCyclePlacetteIdCycleMapListNotifier() : super([]);

  void update(List<Map<String, dynamic>> newList) {
    state = newList;
  }
}

final cycleRowsProvider =
    Provider.autoDispose<List<Map<String, dynamic>>>((ref) {
  // List<Map<String, dynamic>> rowList = objProperties['rowList'];
  // List<Map<String, int>> links = objProperties['links'];
  List<Map<String, dynamic>> links =
      ref.watch(idCyclePlacetteIdCycleMapListProvider);

  List<Map<String, dynamic>> rowList = ref.watch(rowsProvider);
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

// Provider for idCyclePlacetteIdCycleMapList
final displayTypeStateProvider =
    StateNotifierProvider.autoDispose<DisplayTypeStateNotifier, String>((ref) {
  return DisplayTypeStateNotifier();
});

class DisplayTypeStateNotifier extends StateNotifier<String> {
  DisplayTypeStateNotifier() : super('Arbres');

  void update(String displayType) {
    state = displayType;
  }
}

// Provider to get filtered column names
final filteredColumnNamesColumnProvider =
    Provider.autoDispose<List<Map<String, dynamic>>>((ref) {
  List<Map<String, dynamic>> rows = ref.watch(cycleRowsProvider);
  String displayTypeState = ref.watch(displayTypeStateProvider);

  // Filter each row to include only the interested columns
  return rows.map((row) {
    Map<String, dynamic> filteredRow = {};
    row.forEach((key, val) {
      if (shouldIncludeColumn(key, displayTypeState)) {
        filteredRow[key] = val;
      }
    });
    return filteredRow;
  }).toList();
});

// Provider to get filtered column names
final filteredColumnNamesRowProvider =
    Provider.autoDispose<List<Map<String, dynamic>>>((ref) {
  List<Map<String, dynamic>> rows = ref.watch(cycleRowsProvider);
  String displayTypeState = ref.watch(displayTypeStateProvider);

  // Filter each row to include only the interested columns
  return rows.map((row) {
    Map<String, dynamic> filteredRow = {};
    row.forEach((key, val) {
      if (shouldIncludeColumn(key, displayTypeState)) {
        filteredRow[key] = val;
      }
    });
    return filteredRow;
  }).toList();
});

bool shouldIncludeColumn(String columnName, String type) {
  switch (type) {
    case 'Arbres':
      return Arbre.getDisplayableColumn(columnName);
    case 'BmsSup30':
      return BmSup30.getDisplayableColumn(columnName);
    case 'Reperes':
      return Repere.getDisplayableColumn(columnName);
    case 'Regenerations':
      return Regeneration.getDisplayableColumn(columnName);
    case 'Transects':
      return Transect.getDisplayableColumn(columnName);
  }
  return true;
}

final sortColumnIndexProvider = StateProvider<int?>((ref) => null);
final sortAscendingProvider = StateProvider<bool>((ref) => true);

final sortedCycleRowsProvider = StateNotifierProvider.autoDispose<
    SortedCycleRowNotifier, List<Map<String, dynamic>>>((ref) {
  List<Map<String, dynamic>> rows = ref.watch(filteredColumnNamesRowProvider);
  return SortedCycleRowNotifier(rows);
});

class SortedCycleRowNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  SortedCycleRowNotifier(List<Map<String, dynamic>> initialData)
      : super(initialData);

  void sortRows(int sortColumnIndex, bool ascending) {
    List<Map<String, dynamic>> sorted = [...state];

    sorted.sort((a, b) {
      var aValue = a.values.elementAt(sortColumnIndex);
      var bValue = b.values.elementAt(sortColumnIndex);

      // Primary comparison
      int compareResult = _compareValues(aValue, bValue, ascending);

      // Secondary comparison based on idArbreOrig
      if (compareResult == 0) {
        compareResult = _compareValues(
            a.values.elementAt(0), b.values.elementAt(0), ascending);
      }

      // Tertiary comparison based on idCycle
      if (compareResult == 0 &&
          a.containsKey('idCycle') &&
          b.containsKey('idCycle')) {
        compareResult = _compareValues(a['idCycle'], b['idCycle'], ascending);
      }

      return compareResult;
    });

    state = sorted; // Update the state with the new sorted list.
  }

  // Helper method to compare two values with optional ascending order
  int _compareValues(dynamic aValue, dynamic bValue, bool ascending) {
    if (aValue is bool && bValue is bool) {
      return ascending ? (aValue ? -1 : 1) : (aValue ? 1 : -1);
    } else if (aValue is num && bValue is num) {
      return ascending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
    } else {
      return ascending
          ? aValue.toString().compareTo(bValue.toString())
          : bValue.toString().compareTo(aValue.toString());
    }
  }
}

final columnsProvider = Provider.autoDispose
    .family<List<String>, List<Map<String, dynamic>>>((ref, list) {
  if (list.isEmpty) {
    return [];
  }

  // Assuming you have a way to obtain the displayTypeState, e.g., from another provider
  String displayTypeState = ref.watch(displayTypeStateProvider);

  // Filter the column list based on whether they should be included
  return list[0]
      .keys
      .where((columnStr) => shouldIncludeColumn(columnStr, displayTypeState))
      .toList();
});

final arrayWidthProvider =
    Provider.autoDispose.family<double, List<String>>((ref, list) {
  return list.length * columnWidth.toDouble();
});

final selectedItemDetailsProvider = StateNotifierProvider.autoDispose<
    SelectedItemDetailsNotifier, SaisisableObject?>((ref) {
  final lastSelectedProvider = ref.watch(lastSelectedIdProvider.notifier);
  final items = ref.watch(displayableListProvider);

  return SelectedItemDetailsNotifier(
    items,
    lastSelectedProvider,
  );
});

class SelectedItemDetailsNotifier extends StateNotifier<SaisisableObject?> {
  final DisplayableList items;
  late final LastSelectedIdNotifier _lastSelectedProvider;

  SelectedItemDetailsNotifier(
    this.items,
    this._lastSelectedProvider,
  ) : super(null) {
    String lastSelectedId;

    // Check if a map is empy
    if (items.isEmpty()) {
      state = null;
      return;
    } else if (_lastSelectedProvider.getObject().isEmpty) {
      lastSelectedId = items.getFirstElementIdOrig();
    } else if (items is ArbreList) {
      lastSelectedId = _lastSelectedProvider.getLastSelectedId('Arbres') ??
          items.getFirstElementIdOrig();
    } else if (items is BmSup30List) {
      lastSelectedId = _lastSelectedProvider.getLastSelectedId('BmsSup30') ??
          items.getFirstElementIdOrig();
    } else if (items is RegenerationList) {
      lastSelectedId =
          _lastSelectedProvider.getLastSelectedId('Regenerations') ??
              items.getFirstElementIdOrig();
    } else if (items is RepereList) {
      lastSelectedId = _lastSelectedProvider.getLastSelectedId('Repères') ??
          items.getFirstElementIdOrig();
    } else if (items is TransectList) {
      lastSelectedId = _lastSelectedProvider.getLastSelectedId('Transects') ??
          items.getFirstElementIdOrig();
    } else {
      throw ArgumentError('Unknown type: ${items.runtimeType}');
    }

    state = items.getObjectFromId(lastSelectedId);
  }

  SaisisableObject? setSelectedItemDetails(
      Map<String, dynamic> value, String type) {
    switch (type) {
      case 'Arbres':
        _lastSelectedProvider.setLastSelectedId('Arbres', value['idArbreOrig']);
        state = items.getObjectFromId(value['idArbreOrig']);
        return state;
      case 'BmsSup30':
        _lastSelectedProvider.setLastSelectedId(
            'BmsSup30', value['idBmSup30Orig']);
        state = items.getObjectFromId(value['idBmSup30Orig']);
        return state;
      case 'Regenerations':
        _lastSelectedProvider.setLastSelectedId(
            'Regenerations', value['idRegeneration']);
        state = items.getObjectFromId(value['idRegeneration']);
        return state;
      case 'Reperes':
        _lastSelectedProvider.setLastSelectedId('Repere', value['idRepere']);
        state = items.getObjectFromId(value['idRepere']);
        return state;
      case 'Transects':
        _lastSelectedProvider.setLastSelectedId(
            'Transects', value['idTransect']);
        state = items.getObjectFromId(value['idTransect']);
        return state;
      default:
        throw ArgumentError('Unknown type: ${items.runtimeType}');
    }
  }
}

// provider of index of the selected mesure
final selectedMesureIndexProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});

final selectedItemMesureDetailsProvider = StateNotifierProvider.autoDispose<
    SelectedItemMesureDetailsNotifier, SaisisableObject?>((ref) {
  final index = ref.watch(selectedMesureIndexProvider);
  final item = ref.watch(selectedItemDetailsProvider);
  return SelectedItemMesureDetailsNotifier(
    item,
    index,
  );
});

class SelectedItemMesureDetailsNotifier
    extends StateNotifier<SaisisableObject?> {
  final SaisisableObject? item;
  final int index;

  SelectedItemMesureDetailsNotifier(this.item, this.index) : super(null) {
    if (item is Arbre) {
      Arbre arbreDetails = item as Arbre;
      state = arbreDetails.arbresMesures!.values[index];
    } else if (item is BmSup30) {
      BmSup30 bmSup30Details = item as BmSup30;
      state = bmSup30Details.bmsSup30Mesures!.values[index];
    } else {
      state = null;
    }
  }

  // void setSelectedItemMesureDetails(int selectedIndex) {
  //   if (item is Arbre) {
  //     Arbre arbreDetails = item as Arbre;
  //     state = arbreDetails.arbresMesures!.values[selectedIndex];
  //   } else if (item is BmSup30) {
  //     BmSup30 bmSup30Details = item as BmSup30;
  //     state = bmSup30Details.bmsSup30Mesures!.values[selectedIndex];
  //     // } else if (item is Regeneration) {
  //     //   Regeneration regenerationDetails = item as Regeneration;
  //     //   state = regenerationDetails.regenerationsMesures!.values[selectedIndex];
  //     // } else if (item is Repere) {
  //     //   Repere repereDetails = item as Repere;
  //     //   state = repereDetails.reperesMesures!.values[selectedIndex];
  //     // } else if (item is Transect) {
  //     //   Transect transectDetails = item as Transect;
  //     //   state = transectDetails.transectsMesures!.values[selectedIndex];
  //   } else {
  //     state = null;
  //     // throw ArgumentError('Unknown type: ${item.runtimeType}');
  //   }
  //   // case 'BmsSup30':
  //   //   state = item.getObjectFromId(value['idBmSup30Orig']);
  //   //   break;
  //   // case 'Regenerations':
  //   //   state = item.getObjectFromId(value['idRegeneration']);
  //   //   break;
  //   // case 'Repères':
  //   //   state = item.getObjectFromId(value['idRepere']);
  //   //   break;
  //   // case 'Transects':
  //   //   state = item.getObjectFromId(value['idTransectOrig']);
  //   //   break;
  // }
}
