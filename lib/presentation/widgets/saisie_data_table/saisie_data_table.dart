import 'package:dendro3/data/mapper/arbreMesure_mapper.dart';
import 'package:dendro3/data/mapper/arbre_mapper.dart';
import 'package:dendro3/data/mapper/bmSup30Mesure_mapper.dart';
import 'package:dendro3/data/mapper/bmSup30_mapper.dart';
import 'package:dendro3/data/mapper/corCyclePlacette_mapper.dart';
import 'package:dendro3/data/mapper/regeneration_mapper.dart';
import 'package:dendro3/data/mapper/repere_mapper.dart';
import 'package:dendro3/data/mapper/transect_mapper.dart';
import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/arbreMesure.dart';
import 'package:dendro3/domain/model/arbre_list.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/bmSup30Mesure.dart';
import 'package:dendro3/domain/model/bmSup30_list.dart';
import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:dendro3/domain/model/corCyclePlacette_list.dart';
import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/cycle_list.dart';
import 'package:dendro3/domain/model/displayable_list.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/model/placette_list.dart';
import 'package:dendro3/domain/model/regeneration_list.dart';
import 'package:dendro3/domain/model/repere_list.dart';
import 'package:dendro3/domain/model/saisisable_object.dart';
import 'package:dendro3/domain/model/transect_list.dart';
import 'package:dendro3/presentation/view/form_saisie_placette_page.dart';
import 'package:dendro3/presentation/viewmodel/baseList/arbre_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/baseList/bms_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/displayable_list_notifier.dart';
import 'package:dendro3/presentation/viewmodel/dispositif/dispositif_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/last_modified_Id_notifier.dart';
import 'package:dendro3/presentation/viewmodel/placette/saisie_placette_viewmodel.dart';
import 'package:dendro3/presentation/widgets/primary_grid.dart';
import 'package:dendro3/presentation/widgets/saisie_data_table/saisie_data_table_service.dart';
import 'package:dendro3/core/types/saisie_data_table_types.dart';
import 'package:dendro3/presentation/widgets/secondary_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;
import 'package:data_table_2/data_table_2.dart';

import 'package:flutter/scheduler.dart';

class SaisieDataTable extends ConsumerStatefulWidget {
  SaisieDataTable({
    super.key,
    required this.placette,
    // required this.itemList,
    required this.dispCycleList,
    // required this.corCyclePlacetteList,
    required this.displayTypeState,
  });

  // final ArbreList itemList;
  // final int placetteId;
  final Placette placette;
  final CycleList dispCycleList;
  // final CorCyclePlacetteList corCyclePlacetteList;
  final String displayTypeState;

  @override
  SaisieDataTableState createState() => SaisieDataTableState();
}

class SaisieDataTableState extends ConsumerState<SaisieDataTable> {
  final ScrollController _controller = ScrollController();
  double? arrayWidth;
  late List<bool> _extendedList;
  SaisisableObject? selectedItemDetails;
  SaisisableObject? selectedItemMesureDetails;

  @override
  void initState() {
    _extendedList = <bool>[true, false];

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref
          .watch(cycleSelectedProvider.notifier)
          .setCycles(widget.dispCycleList!.values);
      ref
          .watch(reducedToggleProvider.notifier)
          .setToggleList([true, false, false]);
      ref
          .watch(reducedMesureToggleProvider.notifier)
          .setToggleList([true, false, false]);

      ref.watch(cycleSelectedToggleProvider.notifier).setToggleList(
          ref.watch(cycleSelectedProvider.notifier).convertCyclesToToggles());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Cycle> cycleList = ref.watch(cycleSelectedProvider);
    // create a Map with key idCycle and value numCycle
    Map<int, int> mapIdCycleNumCycle = {
      for (Cycle cycle in cycleList) cycle.idCycle: cycle.numCycle
    };

    List<bool> reducedList = ref.watch(reducedToggleProvider);
    List<bool> reducedMesureList = ref.watch(reducedMesureToggleProvider);
    List<bool> cycleToggleSelectedList = ref.watch(cycleSelectedToggleProvider);

    final DisplayableList items = ref.watch(displayableListProvider);

    final rowList = ref.watch(rowsProvider(items));

    // create an object with 2 property: rowList and widget.placette.corCyclesPlacettes!.values
    List<Map<String, int>> idCyclePlacetteIdCycleMapList = [];
    for (var corCyclePlacette in widget.placette.corCyclesPlacettes!.values) {
      idCyclePlacetteIdCycleMapList.add({
        'idCyclePlacette': corCyclePlacette.idCyclePlacette,
        'idCycle': corCyclePlacette.idCycle,
      });
    }

    final cycleRowList = ref.watch(cycleRowsProvider({
      'rowList': rowList,
      'links': idCyclePlacetteIdCycleMapList,
    }));
    final columnNameList = ref.watch(columnsProvider(rowList));
    final arrayWidth = ref.watch(arrayWidthProvider(columnNameList));

    final selectedItemDetails = ref.watch(selectedItemDetailsProvider);

    final selectedItemMesureDetails =
        ref.watch(selectedItemMesureDetailsProvider);

    return Column(
      children: [
        Container(
          height: 300,
          padding: EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            // border: Border(),
            // borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: columnNameList.isEmpty
              ? Text("Il n'y a pas de ${widget.displayTypeState} à afficher")
              : DataTable2(
                  columnSpacing: 12, // Adjusted for better spacing
                  horizontalMargin: 6, // Consistent margin
                  fixedLeftColumns: 1,
                  scrollController: _controller,
                  dividerThickness: 1,
                  showCheckboxColumn: false, // Added dividers for clarity
                  minWidth: _extendedList[0] ? null : arrayWidth,
                  columns: _createColumns(
                    columnNameList,
                  ),
                  rows: _createRows(
                    cycleRowList,
                    items,
                    mapIdCycleNumCycle,
                    selectedItemDetails,
                  ),
                  dataRowHeight:
                      50, // Uncommented and adjusted for better row visibility
                  decoration: BoxDecoration(
                    color: Colors.white, // Consider using theme-based colors
                  ),
                  headingTextStyle: TextStyle(
                    color: Colors.black54,
                    fontWeight:
                        FontWeight.bold, // Custom text style for headers
                  ),
                  dataTextStyle: TextStyle(
                    color: Colors.black, // Custom text style for data
                  ),
                  // Additional customizations like row color, sorting functionality, etc.
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ToggleButtons(
              direction: Axis.horizontal,
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < _extendedList.length; i++) {
                    _extendedList[i] = i == index;
                  }
                  ref.read(reducedToggleProvider.notifier).toggleChanged(index);
                  ref
                      .read(reducedMesureToggleProvider.notifier)
                      .toggleChanged(index);
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.red[700],
              selectedColor: Colors.white,
              fillColor: Colors.red[200],
              color: Colors.red[400],
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              isSelected: _extendedList,
              children: <Widget>[Text('Synthese'), Text('Complet')],
            ),
            SizedBox(width: 10),
            Visibility(
              visible: [0, 1].contains(
                  reducedMesureList.indexWhere((mesure) => mesure == true)),
              child: ToggleButtons(
                isSelected: cycleToggleSelectedList.isNotEmpty
                    ? cycleToggleSelectedList
                    : [],
                onPressed: (int index) {
                  ref
                      .read(cycleSelectedToggleProvider.notifier)
                      .cycleToggleChanged(index);
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: Colors.blue[700],
                selectedColor: Colors.white,
                fillColor: Colors.blue[200],
                color: Colors.blue[400],
                constraints: const BoxConstraints(
                  minHeight: 40.0,
                  minWidth: 80.0,
                ),
                children: <Widget>[
                  ..._generateCircleAvatars(
                    cycleList,
                    widget.placette.corCyclesPlacettes!,
                  ),
                ],
              ),
            ),
          ],
        ),
        if (selectedItemDetails != null)
          _buildSelectedItemDetails(
              selectedItemDetails, selectedItemMesureDetails),
      ],
    );
  }

  Widget _buildSelectedItemDetails(
    SaisisableObject? selectedItemDetailsCo,
    SaisisableObject? selectedItemMesureDetailsCo,
  ) {
    // final selectedItemDetailsCo = ref.read(selectedItemDetailsProvider);
    // Check if selectedItemDetails is null
    if (selectedItemDetailsCo == null) {
      return Text("No item selected.");
    }

    List<MapEntry<String, dynamic>> simpleElements = [];
    List<dynamic> mesuresList = [];

    // Extracting the data
    int currentIndex = 0;
    var allValues = selectedItemDetailsCo!.getAllValuesMapped();
    allValues.entries.forEach((entry) {
      if (entry.key == "arbresMesures" && entry.value is List) {
        mesuresList = entry.value;
        selectedItemDetailsCo as Arbre;
        selectedItemMesureDetailsCo as ArbreMesure;
        currentIndex = selectedItemDetailsCo.arbresMesures!
                .findIndexOfArbreMesure(selectedItemMesureDetailsCo) ??
            currentIndex;
      } else if (entry.key == "bmsSup30Mesures" && entry.value is List) {
        mesuresList = entry.value;
        selectedItemDetailsCo as BmSup30;
        selectedItemMesureDetailsCo as BmSup30Mesure;
        currentIndex = selectedItemDetailsCo.bmsSup30Mesures!
                .findIndexOfBmSup30Mesure(selectedItemMesureDetailsCo) ??
            currentIndex;
        mesuresList = entry.value;
      } else {
        simpleElements.add(entry);
      }
    });

    return Container(
      margin: EdgeInsets.all(10), // Marge externe
      decoration: BoxDecoration(
        color: Colors.grey[200], // Couleur de fond
        borderRadius: BorderRadius.circular(15), // Bords arrondis
      ),
      child: Column(
        children: [
          PrimaryGridWidget(
            simpleElements: simpleElements,
            onItemAdded: (dynamic item) {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return FormSaisiePlacettePage(
                    formType: "add",
                    type: widget.displayTypeState,
                    placette: widget.placette,
                    cycle: getCycleFromType(
                      'add',
                      widget.dispCycleList,
                    ),
                    corCyclePlacette: getCorCyclePlacetteFromType(
                      'add',
                      widget.placette,
                      widget.dispCycleList,
                    ),
                    saisisableObject1: null,
                    saisisableObject2: null,
                  );
                },
              ));
            },
            onItemDeleted: (dynamic item) {
              if (selectedItemDetailsCo is Arbre) {
                final arbreListViewModel =
                    ref.read(arbreListViewModelStateNotifierProvider.notifier);
                // Arbre? arbreDetails = selectedItemDetailsCo as Arbre?;
                // if (arbreDetails != null) {
                arbreListViewModel.deleteItem(selectedItemDetailsCo.idArbre);
                // }
              }
            },
            onItemUpdated: (dynamic item) {
              // Logic for updating an item
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return FormSaisiePlacettePage(
                    formType: "edit",
                    type: widget.displayTypeState,
                    placette: widget.placette,
                    cycle: getCycleFromType(
                      'edit',
                      widget.dispCycleList,
                      selectedItemMesureDetailsCo,
                    ),
                    corCyclePlacette: getCorCyclePlacetteFromType(
                      'add',
                      widget.placette,
                      widget.dispCycleList,
                    ),
                    saisisableObject1: selectedItemDetailsCo,
                    saisisableObject2: selectedItemMesureDetailsCo,
                  );
                },
              ));
            },
          ),

          // Only create SecondaryGrid if arbresMesuresList is not empty
          if (mesuresList.isNotEmpty)
            Container(
              margin: EdgeInsets.all(5), // Marge externe
              decoration: BoxDecoration(
                color: Colors.grey[400], // Couleur de fond
                borderRadius: BorderRadius.circular(15), // Bords arrondis
              ),
              child: SecondaryGrid(
                mesuresList: mesuresList,
                currentIndex: currentIndex,
                onItemSelected: (int selectedIndex) {
                  ref.watch(selectedMesureIndexProvider.notifier).state =
                      selectedIndex;
                  // ref
                  //     .read(selectedItemMesureDetailsProvider.notifier)
                  //     .setSelectedItemMesureDetails(selectedIndex);
                },
                onItemMesureAdded: (dynamic adedItem) async {
                  Navigator.push(context, MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return FormSaisiePlacettePage(
                        formType: "newMesure",
                        type: widget.displayTypeState,
                        placette: widget.placette,
                        cycle: getCycleFromType(
                          'newMesure',
                          widget.dispCycleList,
                        ),
                        corCyclePlacette: getCorCyclePlacetteFromType(
                          'add',
                          widget.placette,
                          widget.dispCycleList,
                        ),
                        saisisableObject1: selectedItemDetailsCo,
                        saisisableObject2: null,
                      );
                    },
                  ));
                },
                onItemMesureDeleted: (dynamic deletedItem) async {
                  bool result = false;
                  // if map contain idArbre then it's an ArbreMesure
                  if (deletedItem.containsKey('idArbreMesure')) {
                    final arbreListViewModel = ref
                        .read(arbreListViewModelStateNotifierProvider.notifier);
                    selectedItemDetailsCo as Arbre;
                    result = await arbreListViewModel.deleteItemMesure(
                        selectedItemDetailsCo.idArbre,
                        deletedItem['idArbreMesure']);
                  } else if (deletedItem.containsKey('idBmSup30Mesure')) {
                    final bmSup30ListViewModel = ref.read(
                        bmSup30ListViewModelStateNotifierProvider.notifier);
                    bmSup30ListViewModel
                        .deleteItemMesure(deletedItem['idBmSup30Mesure']);
                  }

                  if (!result) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Cannot delete the only mesure of an arbre.'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                },
                onItemMesureUpdated: (dynamic updatedItem) {
                  Navigator.push(context, MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return FormSaisiePlacettePage(
                        formType: "edit",
                        type: widget.displayTypeState,
                        placette: widget.placette,
                        cycle: getCycleFromType(
                          'edit',
                          widget.dispCycleList,
                          selectedItemMesureDetailsCo,
                        ),
                        corCyclePlacette: getCorCyclePlacetteFromType(
                          'add',
                          widget.placette,
                          widget.dispCycleList,
                        ),
                        saisisableObject1: selectedItemDetailsCo,
                        saisisableObject2: selectedItemMesureDetailsCo,
                      );
                    },
                  ));
                },
              ),
            ),
        ],
      ),
    );
  }

  void onSelectedItemChanged(
    int selectedIndex,
    Map<String, dynamic> value,
    String type,
    DisplayableList items,
  ) {
    final SaisisableObject? selectedItem = ref
        .read(selectedItemDetailsProvider.notifier)
        .setSelectedItemDetails(value, widget.displayTypeState);

    if (selectedItem is Arbre) {
      selectedItem as Arbre;
      ref.watch(selectedMesureIndexProvider.notifier).state =
          selectedItem.arbresMesures!.findIndexOfArbreMesureFromIdArbreMesure(
                  value['idArbreMesure']) ??
              0;
    } else if (selectedItem is BmSup30) {
      selectedItem as BmSup30;
      ref.watch(selectedMesureIndexProvider.notifier).state = selectedItem
              .bmsSup30Mesures!
              .findIndexOfBmSup30MesureFromIdBmSup30Mesure(
                  value['idBmSup30Mesure']) ??
          0;
    }

    // ref
    //     .read(selectedItemMesureDetailsProvider.notifier)
    //     .setSelectedItemMesureDetails(selectedIndex);

    // if (selectedItemDetails is Arbre) {
    //   Arbre arbreDetails = selectedItemDetails as Arbre;
    //   selectedItemMesureDetails =
    //       arbreDetails.arbresMesures!.values[selectedIndex];
    // }
    // onSelectedItemIndexChanged(selectedIndex);
    // switch (widget.displayTypeState) {
    //   case 'Arbres':
    //     selectedItemMesureDetails = selectedItemDetails!
    //         .arbresMesures.values[selectedIndex] as ArbreMesure;
    //     // selectedItemMesureDetails =
    //     //     getObjectFromType(selectedItemDetails!.arbresMesures.values[selectedIndex], items, 'Arbres');
    //     // selectedItemMesureDetails =
    //     // selectedItemDetails!.arbresMesures.values[selectedIndex];

    //     break;
    //   case 'BmsSup30':

    // case 'BmsSup30':
    //   return items.getObjectFromId(value['idBmSup30Orig']);
    // case 'Regenerations':
    //   return items.getObjectFromId(value['idRegeneration']);
    // case 'Repères':
    //   return items.getObjectFromId(value['idRepere']);
    // case 'Transects':
    //   return items.getObjectFromId(value['idTransectOrig']);
    // default:
    //   throw ArgumentError('Unknown type: ${items.runtimeType}');
    // }

    // if (selectedItemDetails != null &&
    //     selectedIndex < selectedItemDetails?.arbresMesures.values.length) {
    //   setState(() {
    //     selectedArbreMesure =
    //         selectedItemDetails?.arbresMesures.values[selectedIndex];
    //   });
    // }
  }

  List<DataColumn> _createColumns(List<String> columnList) {
    List<DataColumn> columns = [];

    // Ajouter d'abord la colonne "update"
    columns.add(
      DataColumn2(
        label: SizedBox.shrink(), // Empty label for the update icon
      ),
    );

    // Ajouter les autres colonnes
    columns.addAll(
      columnList.map(
        (columnStr) => DataColumn2(
          label: Text(
            columnStr,
            style: TextStyle(fontSize: 12),
          ),
          numeric: true,
        ),
      ),
    );

    return columns;
  }

  List<DataRow> _createRows(
    List<Map<String, dynamic>> valueList,
    DisplayableList items,
    Map<int, int> mapIdCycleNumCycle,
    SaisisableObject? selectedItemDetails,
  ) {
    return valueList.map<DataRow>((value) {
      List<DataCell> cellList = [];
      bool isSelected = false;
      int selectedIndex = 0;

      if (selectedItemDetails != null) {
        if (selectedItemDetails!.isEqualToMap(value)) {
          isSelected = true;
        }
      }

      // Ajouter une cellule pour la colonne "update" au début
      cellList.add(
        DataCell(
          SizedBox(
            width: 32, // Adjust the width as needed
            height: 24,
            child: IconButton(
              padding: EdgeInsets.only(left: 12),
              icon: Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                size: 24,
              ),
              onPressed: () {
                onSelectedItemChanged(
                  selectedIndex,
                  value,
                  widget.displayTypeState,
                  items,
                );
              },
            ),
          ),
        ),
      );

      // Ajouter les autres cellules
      cellList.addAll(
        value.values.map<DataCell>((yo) {
          return DataCell(Text(
            yo.toString(),
            style: TextStyle(fontSize: 12),
          ));
        }),
      );

      return DataRow(
        cells: cellList,
        color: MaterialStateProperty.resolveWith<Color?>((states) {
          // Use a different Color for each idCycle of mapIdCycleNumCycle, according to numCycle
          if (mapIdCycleNumCycle[value["idCycle"]] == 1) {
            return Colors.white;
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 2) {
            return Colors.blue[100];
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 3) {
            return Colors.blue[200];
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 4) {
            return Colors.blue[300];
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 5) {
            return Colors.blue[400];
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 6) {
            return Colors.blue;
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 7) {
            return Colors.blue[600];
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 8) {
            return Colors.blue[700];
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 9) {
            return Colors.blue[800];
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 10) {
            return Colors.blue[900];
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 11) {
            return Colors.green;
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 12) {
            return Colors.lime;
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 13) {
            return Colors.amber;
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 14) {
            return Colors.cyan;
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 15) {
            return Colors.deepOrange;
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 16) {
            return Colors.deepPurple;
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 17) {
            return Colors.lightBlue;
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 18) {
            return Colors.lightGreen;
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 19) {
            return Colors.limeAccent;
          }
        }),
      );
    }).toList();
  }

  List<Widget> _generateCircleAvatars(
      List<Cycle> cycleList, CorCyclePlacetteList corCyclePlacetteList) {
    var list = cycleList
        .map<Widget>((data) => CircleAvatar(
              backgroundColor: corCyclePlacetteList.values
                      .map((CorCyclePlacette corCyclePlacette) =>
                          corCyclePlacette.idCycle)
                      .contains(data.idCycle)
                  ? Colors.green
                  : Colors.red,
              foregroundColor: Colors.white,
              radius: 10,
              child: Text(
                data.numCycle.toString(),
              ),
            ))
        .toList();
    return list;
  }
}

SaisisableObject getObjectFromType(
    Map<String, dynamic> value, DisplayableList items, String type) {
  switch (type) {
    case 'Arbres':
      return items.getObjectFromId(value['idArbreOrig']);
    case 'BmsSup30':
      return items.getObjectFromId(value['idBmSup30Orig']);
    case 'Regenerations':
      return items.getObjectFromId(value['idRegeneration']);
    case 'Repères':
      return items.getObjectFromId(value['idRepere']);
    case 'Transects':
    case 'BmsInf30':
      return items.getObjectFromId(value['idTransectOrig']);
    default:
      throw ArgumentError('Unknown type: ${items.runtimeType}');
  }
}

Cycle? getCycleFromType(String formType, CycleList dispCycleList,
    [SaisisableObject? selectedItemMesureDetails]) {
  if (formType == 'edit') {
    if (selectedItemMesureDetails is ArbreMesure) {
      return dispCycleList.findCycleById(selectedItemMesureDetails!.idCycle);
    } else if (selectedItemMesureDetails is BmSup30Mesure) {
      return dispCycleList.findCycleById(selectedItemMesureDetails!.idCycle);
    } else if (selectedItemMesureDetails is CorCyclePlacette) {
      CorCyclePlacette aaa = selectedItemMesureDetails as CorCyclePlacette;
      return dispCycleList.findCycleById(aaa!.idCycle);
    } else {
      return null;
    }
  } else if (formType == 'newMesure') {
    return dispCycleList.findIdOfCycleWithLargestNumCycle();
  } else if (formType == 'add') {
    return dispCycleList.findIdOfCycleWithLargestNumCycle();
  } else {
    return null;
  }
}

CorCyclePlacette? getCorCyclePlacetteFromType(
    String formType, Placette placette, CycleList dispCycleList) {
  Cycle? cycle = dispCycleList.findIdOfCycleWithLargestNumCycle();
  // Get the idCyclePlacette of the corCyclePlacette corresponding to the cycle
  if (formType == 'add' || formType == 'newMesure') {
    return placette.corCyclesPlacettes!
        .getCorCyclePlacetteByIdCycle(cycle!.idCycle);
  } else {
    return null;
  }
}
