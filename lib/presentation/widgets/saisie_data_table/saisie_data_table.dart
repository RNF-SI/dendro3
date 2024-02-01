import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/arbreMesure.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/bmSup30Mesure.dart';
import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:dendro3/domain/model/corCyclePlacette_list.dart';
import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/cycle_list.dart';
import 'package:dendro3/domain/model/displayable_list.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/model/regeneration.dart';
import 'package:dendro3/domain/model/repere.dart';
import 'package:dendro3/domain/model/saisisable_object.dart';
import 'package:dendro3/domain/model/saisisable_object_mesure.dart';
import 'package:dendro3/domain/model/transect.dart';
import 'package:dendro3/presentation/lib/simple_element.dart';
import 'package:dendro3/presentation/view/form_saisie_placette_page.dart';
import 'package:dendro3/presentation/viewmodel/baseList/arbre_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/baseList/bms_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/baseList/regeneration_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/baseList/repere_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/baseList/transect_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/cor_cycle_placette_local_storage_provider.dart';
import 'package:dendro3/presentation/viewmodel/displayable_list_notifier.dart';
import 'package:dendro3/presentation/widgets/primary_grid.dart';
import 'package:dendro3/presentation/widgets/saisie_data_table/saisie_data_table_service.dart';
import 'package:dendro3/presentation/widgets/secondary_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:data_table_2/data_table_2.dart';

class SaisieDataTable extends ConsumerStatefulWidget {
  const SaisieDataTable({
    super.key,
    required this.placette,
    // required this.itemList,
    required this.dispCycleList,
    required this.corCyclePlacetteList,
    required this.displayTypeState,
  });

  // final ArbreList itemList;
  // final int placetteId;
  final Placette placette;
  final CycleList dispCycleList;
  final CorCyclePlacetteList corCyclePlacetteList;
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

  int? _sortColumnIndex;
  bool _sortAscending = true;

  // late CorCyclePlacetteList corCyclePlacetteList;

  @override
  void initState() {
    _extendedList = <bool>[true, false];

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref
          .watch(cycleSelectedProvider.notifier)
          .setCycles(widget.dispCycleList.values);
      ref
          .watch(reducedToggleProvider.notifier)
          .setToggleList([true, false, false]);
      ref
          .watch(reducedMesureToggleProvider.notifier)
          .setToggleList([true, false, false]);

      ref.watch(cycleSelectedToggleProvider.notifier).setToggleList(
          ref.watch(cycleSelectedProvider.notifier).convertCyclesToToggles());

      // create an object with 2 property: rowList and widget.placette.corCyclesPlacettes!.values
      List<Map<String, dynamic>> idCyclePlacetteIdCycleMapList = [];
      for (var corCyclePlacette in widget.corCyclePlacetteList.values) {
        idCyclePlacetteIdCycleMapList.add({
          'idCyclePlacette': corCyclePlacette.idCyclePlacette,
          'idCycle': corCyclePlacette.idCycle,
        });
      }

      ref
          .read(idCyclePlacetteIdCycleMapListProvider.notifier)
          .update(idCyclePlacetteIdCycleMapList);
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

    Map<String, int> mapNumCyclePlacetteNumCycle = {};

    // create a Map with key idCyclePlacette and value numCycle
    if (cycleList.isNotEmpty) {
      mapNumCyclePlacetteNumCycle = {
        for (CorCyclePlacette corCyclePlacette
            in widget.corCyclePlacetteList.values)
          corCyclePlacette.idCyclePlacette: mapIdCycleNumCycle[corCyclePlacette
              .idCycle]! // get the numCycle from mapIdCycleNumCycle
      };
    }

    // List<bool> reducedList = ref.watch(reducedToggleProvider);
    List<bool> reducedMesureList = ref.watch(reducedMesureToggleProvider);
    List<bool> cycleToggleSelectedList = ref.watch(cycleSelectedToggleProvider);

    final DisplayableList items = ref.watch(displayableListProvider);

    final rowList = ref.watch(rowsProvider);

    final sortedCycleRowList = ref.watch(sortedCycleRowsProvider);

    final columnNameList = ref.watch(columnsProvider(rowList));

    final arrayWidth = ref.watch(arrayWidthProvider(columnNameList));

    final selectedItemDetails = ref.watch(selectedItemDetailsProvider);

    final selectedItemMesureDetails =
        ref.watch(selectedItemMesureDetailsProvider);

    final corCyclePlacetteLocalStorageStatusProvider = ref
        .read(corCyclePlacetteLocalStorageStatusStateNotifierProvider.notifier);

    final columns = _createColumns(
      columnNameList,
    );
    Map<String, bool> columnVisibility =
        getColumnVisibility(columnNameList, widget.displayTypeState);

    final rows = _createRows(
      sortedCycleRowList,
      items,
      mapIdCycleNumCycle,
      mapNumCyclePlacetteNumCycle,
      selectedItemDetails,
      columnVisibility,
    );

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 300,
            padding: const EdgeInsets.only(right: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              // border: Border(),
              // borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: columnNameList.isEmpty
                ? Text("Il n'y a pas de ${widget.displayTypeState} à afficher")
                : DataTable2(
                    columnSpacing: 0, // Adjusted for better spacing
                    horizontalMargin: 1, // Consistent margin
                    fixedLeftColumns: 1,
                    scrollController: _controller,
                    dividerThickness: 1,
                    showCheckboxColumn: false, // Added dividers for clarity
                    minWidth: _extendedList[0] ? null : arrayWidth,
                    columns: columns,
                    rows: rows,
                    dataRowHeight:
                        50, // Uncommented and adjusted for better row visibility
                    decoration: const BoxDecoration(
                      color: Colors.white, // Consider using theme-based colors
                    ),
                    headingTextStyle: const TextStyle(
                      color: Colors.black54,
                      fontWeight:
                          FontWeight.bold, // Custom text style for headers
                    ),
                    dataTextStyle: const TextStyle(
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
                    ref
                        .read(reducedToggleProvider.notifier)
                        .toggleChanged(index);
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
                children: const <Widget>[Text('Synthese'), Text('Complet')],
              ),
              const SizedBox(width: 5),
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
                    minWidth: 40.0,
                  ),
                  children: <Widget>[
                    ..._generateCircleAvatars(
                      cycleList,
                      widget.corCyclePlacetteList,
                      corCyclePlacetteLocalStorageStatusProvider,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (selectedItemDetails != null)
            _buildSelectedItemDetails(
              selectedItemDetails,
              selectedItemMesureDetails,
              mapIdCycleNumCycle,
              mapNumCyclePlacetteNumCycle,
            ),
        ],
      ),

      // Add the FloatingActionButton here
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Define the action to be performed when the FAB is pressed
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return FormSaisiePlacettePage(
                  formType: "add",
                  type: widget.displayTypeState,
                  placette: widget.placette,
                  cycle: getCycleFromType('add', widget.dispCycleList),
                  corCyclePlacette: getCorCyclePlacetteFromType(
                    'add',
                    widget.corCyclePlacetteList,
                    widget.dispCycleList,
                  ),
                  saisisableObject1: null,
                  saisisableObject2: null,
                );
              },
            ),
          );
        },
        tooltip: 'Ajouter un ${widget.displayTypeState}',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSelectedItemDetails(
    SaisisableObject? selectedItemDetailsCo,
    SaisisableObject? selectedItemMesureDetailsCo,
    Map<int, int> mapIdCycleNumCycle,
    Map<String, int> mapNumCyclePlacetteNumCycle,
  ) {
    // final selectedItemDetailsCo = ref.read(selectedItemDetailsProvider);
    // Check if selectedItemDetails is null
    if (selectedItemDetailsCo == null) {
      return const Text("No item selected.");
    }

    SimpleElement simpleElements = SimpleElement();
    List<dynamic> mesuresList = [];

    // Extracting the data
    int currentIndex = 0;
    var allValues = selectedItemDetailsCo.getAllValuesMapped();
    for (var entry in allValues.entries) {
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
        mesuresList = [];
        simpleElements.addEntry(entry.key, entry.value);
      }
    }

    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(10), // Marge externe
        decoration: BoxDecoration(
          color: Colors.grey[200], // Couleur de fond
          borderRadius: BorderRadius.circular(15), // Bords arrondis
        ),
        child: Column(
          children: [
            PrimaryGridWidget(
              simpleElements: simpleElements,
              displayTypeState: widget.displayTypeState,
              mapNumCyclePlacetteNumCycle: mapNumCyclePlacetteNumCycle,
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
                        widget.corCyclePlacetteList,
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
                  final arbreListViewModel = ref
                      .read(arbreListViewModelStateNotifierProvider.notifier);
                  // Arbre? arbreDetails = selectedItemDetailsCo as Arbre?;
                  // if (arbreDetails != null) {
                  arbreListViewModel.deleteItem(selectedItemDetailsCo.idArbre);
                  // }
                } else if (selectedItemDetailsCo is BmSup30) {
                  final bmSup30ListViewModel = ref
                      .read(bmSup30ListViewModelStateNotifierProvider.notifier);
                  bmSup30ListViewModel
                      .deleteItem(selectedItemDetailsCo.idBmSup30);
                } else if (selectedItemDetailsCo is Regeneration) {
                  final regenerationListViewModel = ref.read(
                      regenerationListViewModelStateNotifierProvider.notifier);
                  regenerationListViewModel
                      .deleteItem(selectedItemDetailsCo.idRegeneration);
                } else if (selectedItemDetailsCo is Repere) {
                  final repereListViewModel = ref
                      .read(repereListViewModelStateNotifierProvider.notifier);
                  repereListViewModel
                      .deleteItem(selectedItemDetailsCo.idRepere);
                } else if (selectedItemDetailsCo is Transect) {
                  final transectListViewModel = ref.read(
                      transectListViewModelStateNotifierProvider.notifier);
                  transectListViewModel
                      .deleteItem(selectedItemDetailsCo.idTransect);
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
                        widget.corCyclePlacetteList,
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
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(4),
                  margin: const EdgeInsets.all(5), // Marge externe
                  decoration: BoxDecoration(
                    color: Colors.grey[400], // Couleur de fond
                    borderRadius: BorderRadius.circular(15), // Bords arrondis
                  ),
                  child: SecondaryGrid(
                    mesuresList: mesuresList,
                    currentIndex: currentIndex,
                    mapIdCycleNumCycle: mapIdCycleNumCycle,
                    displayTypeState: widget.displayTypeState,
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
                          bool hasPreviousMeasurements = false;
                          if (widget.displayTypeState == "Arbres") {
                            selectedItemDetailsCo as SaisisableObjectMesure;
                            hasPreviousMeasurements =
                                selectedItemDetailsCo.getMesureValuesLength() >
                                        0
                                    ? true
                                    : false;
                          }

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
                              widget.corCyclePlacetteList,
                              widget.dispCycleList,
                            ),
                            saisisableObject1: selectedItemDetailsCo,
                            saisisableObject2: null,
                            hasPreviousMeasurements: hasPreviousMeasurements,
                          );
                        },
                      ));
                    },
                    onItemMesureDeleted: (dynamic deletedItem) async {
                      bool result = false;
                      // if map contain idArbre then it's an ArbreMesure
                      if (deletedItem.containsKey('idArbreMesure')) {
                        final arbreListViewModel = ref.read(
                            arbreListViewModelStateNotifierProvider.notifier);
                        selectedItemDetailsCo as Arbre;
                        result = await arbreListViewModel.deleteItemMesure(
                            selectedItemDetailsCo.idArbre,
                            deletedItem['idArbreMesure'],
                            deletedItem['idCycle'],
                            mapIdCycleNumCycle[deletedItem['idCycle']]!);
                      } else if (deletedItem.containsKey('idBmSup30Mesure')) {
                        final bmSup30ListViewModel = ref.read(
                            bmSup30ListViewModelStateNotifierProvider.notifier);
                        bmSup30ListViewModel
                            .deleteItemMesure(deletedItem['idBmSup30Mesure']);
                      }

                      if (!result) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Cannot delete the only mesure of an arbre.'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    onItemMesureUpdated: (int index) {
                      Navigator.push(context, MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          // Get the coupe info of the previous cycle
                          // Get previous cycle
                          String? previousCycleCoupe;
                          bool hasPreviousMeasurements = false;
                          if (widget.displayTypeState == "Arbres") {
                            selectedItemDetailsCo as SaisisableObjectMesure;
                            int? numCycle = mapIdCycleNumCycle[
                                selectedItemDetailsCo
                                    .getMesureFromIndex(index)
                                    .idCycle];
                            // get previous cycle with numCycle - 1
                            int? previousCycle = numCycle! - 1;
                            if (previousCycle != 0) {
                              // get previous cycle idCycle
                              int? previousCycleIdCycle = mapIdCycleNumCycle
                                  .entries
                                  .firstWhere((element) =>
                                      element.value == previousCycle)
                                  .key;

                              // get coupe value of previous Cycle with previousCycleIdCycle
                              ArbreMesure? previousArbreMesure =
                                  selectedItemDetailsCo.getMesureFromIdCycle(
                                      previousCycleIdCycle);

                              if (previousArbreMesure != null) {
                                hasPreviousMeasurements = true;
                                previousCycleCoupe = previousArbreMesure.coupe;
                              } else {
                                hasPreviousMeasurements = false;
                                previousCycleCoupe = '';
                              }
                            }
                          }
                          return FormSaisiePlacettePage(
                            formType: "edit",
                            type: widget.displayTypeState,
                            placette: widget.placette,
                            cycle: getCycleFromType(
                              'edit',
                              widget.dispCycleList,
                              selectedItemDetailsCo is SaisisableObjectMesure
                                  ? selectedItemDetailsCo
                                      .getMesureFromIndex(index)
                                  : null,
                            ),
                            corCyclePlacette: getCorCyclePlacetteFromType(
                              'add',
                              widget.corCyclePlacetteList,
                              widget.dispCycleList,
                            ),
                            saisisableObject1: selectedItemDetailsCo,
                            // saisisableObject2: selectedItemMesureDetailsCo,
                            saisisableObject2:
                                selectedItemDetailsCo is SaisisableObjectMesure
                                    ? selectedItemDetailsCo
                                        .getMesureFromIndex(index)
                                    : null,
                            previousCycleCoupe: previousCycleCoupe,
                            hasPreviousMeasurements: hasPreviousMeasurements,
                          );
                        },
                      ));
                    },
                  ),
                ),
              ),
          ],
        ),
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
      selectedItem;
      ref.watch(selectedMesureIndexProvider.notifier).state = selectedItem
              .arbresMesures!
              .findIndexOfArbreMesureFromIdCycle(value['idCycle']) ??
          0;
    } else if (selectedItem is BmSup30) {
      selectedItem;
      ref.watch(selectedMesureIndexProvider.notifier).state = selectedItem
              .bmsSup30Mesures!
              .findIndexOfBmSup30MesureFromIdCycle(value['idCycle']) ??
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

    // Filter the column list first based on whether they should be included
    // List<String> filteredColumnList = columnList
    //     .where((columnStr) =>
    //         shouldIncludeColumn(columnStr, widget.displayTypeState))
    //     .toList();

    List<Map<String, dynamic>> columnTitles =
        _getColumnTitlesForType(columnList, widget.displayTypeState);

    // Ajouter d'abord la colonne "update"
    columns.add(
      const DataColumn2(
        label: SizedBox.shrink(), // Empty label for the update icon
      ),
    );

    for (var columnInfo in columnTitles) {
      if (columnInfo['visible']) {
        // Check if column should be included based on displayType
        columns.add(DataColumn2(
          label:
              Text(columnInfo['title'], style: const TextStyle(fontSize: 12)),
          numeric: true,
          onSort: (columnIndex, _) {
            setState(() {
              if (_sortColumnIndex == columnIndex) {
                // If the same column is clicked again, toggle the sort direction
                _sortAscending = !_sortAscending;
              } else {
                // If a different column is clicked, start with ascending order
                _sortColumnIndex = columnIndex;
                _sortAscending = true;
              }
            });

            // On utilise la function sort row avec columnIndex -1 car on a une colonne pour cliquer la ligne
            // Mais on ajoute 1, car l'id n'est affiché pour aucune des tables
            ref
                .read(sortedCycleRowsProvider.notifier)
                .sortRows(columnIndex, _sortAscending);
            // _onSortColumn(columnIndex, ascending);
          },
        ));
      }
    }

    return columns;
  }

  List<DataRow> _createRows(
    List<Map<String, dynamic>> valueList,
    DisplayableList items,
    Map<int, int> mapIdCycleNumCycle,
    Map<String, int> mapNumCyclePlacetteNumCycle,
    SaisisableObject? selectedItemDetails,
    Map<String, bool> columnVisibility,
  ) {
    return valueList.map<DataRow>((value) {
      List<DataCell> cellList = [];
      bool isSelected = false;
      int selectedIndex = 0;

      if (selectedItemDetails != null) {
        if (selectedItemDetails.isEqualToMap(value)) {
          isSelected = true;
        }
      }

      // Ajouter une cellule pour la colonne "update" au début
      cellList.add(
        DataCell(
          SizedBox(
            width: 24, // Adjust the width as needed
            height: 24,
            child: IconButton(
              padding: const EdgeInsets.only(left: 6, right: 30),
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

      // Create cells based on the new column order
      value.forEach((key, val) {
        if (columnVisibility[key] ?? true) {
          if (key == "idCycle" && mapIdCycleNumCycle.containsKey(val)) {
            cellList.add(DataCell(Text(
              mapIdCycleNumCycle[val].toString(),
              style: const TextStyle(fontSize: 15),
            )));
          } else if (key == "idCyclePlacette" &&
              mapNumCyclePlacetteNumCycle.containsKey(val)) {
            cellList.add(DataCell(Text(
              mapNumCyclePlacetteNumCycle[val].toString(),
              style: const TextStyle(fontSize: 15),
            )));
          } else {
            String displayValue;
            if (val is double) {
              displayValue = val == val.toInt()
                  ? val.toInt().toString()
                  : val.toStringAsFixed(1);
            } else {
              displayValue = val.toString();
            }
            cellList.add(
              DataCell(
                Text(
                  displayValue,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            );
          }
        }
      });

      return DataRow(
        cells: cellList,
        color: MaterialStateProperty.resolveWith<Color?>((states) {
          // Use a different Color for each Cycle
          //For arbre or bmsup30 use mapIdCycleNumCycle, to get the numCycle
          //For other type use mapIdCyclePlacetteNumCycle, to get the numCycle

          if (mapIdCycleNumCycle[value["idCycle"]] == 1 ||
              mapNumCyclePlacetteNumCycle[value["idCyclePlacette"]] == 1) {
            return Colors.white;
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 2 ||
              mapNumCyclePlacetteNumCycle[value["idCyclePlacette"]] == 2) {
            return Colors.blue[200];
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 3 ||
              mapNumCyclePlacetteNumCycle[value["idCyclePlacette"]] == 3) {
            return Colors.blue[400];
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 4 ||
              mapNumCyclePlacetteNumCycle[value["idCyclePlacette"]] == 4) {
            return Colors.blue[600];
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 5 ||
              mapNumCyclePlacetteNumCycle[value["idCyclePlacette"]] == 5) {
            return Colors.blue[800];
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 6 ||
              mapNumCyclePlacetteNumCycle[value["idCyclePlacette"]] == 6) {
            return Colors.blue[900];
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 7 ||
              mapNumCyclePlacetteNumCycle[value["idCyclePlacette"]] == 7) {
            return Colors.green;
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 8 ||
              mapNumCyclePlacetteNumCycle[value["idCyclePlacette"]] == 8) {
            return Colors.lime;
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 9 ||
              mapNumCyclePlacetteNumCycle[value["idCyclePlacette"]] == 9) {
            return Colors.amber;
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 10 ||
              mapNumCyclePlacetteNumCycle[value["idCyclePlacette"]] == 10) {
            return Colors.cyan;
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 11 ||
              mapNumCyclePlacetteNumCycle[value["idCyclePlacette"]] == 11) {
            return Colors.deepOrange;
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 12 ||
              mapNumCyclePlacetteNumCycle[value["idCyclePlacette"]] == 12) {
            return Colors.deepPurple;
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 13 ||
              mapNumCyclePlacetteNumCycle[value["idCyclePlacette"]] == 13) {
            return Colors.lightBlue;
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 14 ||
              mapNumCyclePlacetteNumCycle[value["idCyclePlacette"]] == 14) {
            return Colors.lightGreen;
          } else if (mapIdCycleNumCycle[value["idCycle"]] == 15 ||
              mapNumCyclePlacetteNumCycle[value["idCyclePlacette"]] == 15) {
            return Colors.limeAccent;
          }
          return null;
        }),
      );
    }).toList();
  }

  List<Map<String, dynamic>> _getColumnTitlesForType(
      List<String> columnList, String type) {
    switch (type) {
      case 'Arbres':
        return Arbre.changeColumnName(columnList);
      case 'BmsSup30':
        return BmSup30.changeColumnName(columnList);
      case 'Reperes':
        return Repere.changeColumnName(columnList);
      case 'Regenerations':
        return Regeneration.changeColumnName(columnList);
      case 'Transects':
        return Transect.changeColumnName(columnList);
      case 'Repères':
        return Repere.changeColumnName(columnList);
      default:
        throw ArgumentError('Unknown type: $type');
    }
  }

  // This function should be called to get the column visibility information
  Map<String, bool> getColumnVisibility(List<String> columnList, String type) {
    List<Map<String, dynamic>> columnTitles =
        _getColumnTitlesForType(columnList, type);
    Map<String, bool> columnVisibility = {};

    for (var columnInfo in columnTitles) {
      columnVisibility[columnInfo['title']] = columnInfo['visible'];
    }

    return columnVisibility;
  }

//   List<Widget> _generateCircleAvatars(
//       List<Cycle> cycleList, CorCyclePlacetteList corCyclePlacetteList) {
//     var list = cycleList
//         .map<Widget>((data) => CircleAvatar(
//               backgroundColor: corCyclePlacetteList.values
//                       .map((CorCyclePlacette corCyclePlacette) =>
//                           corCyclePlacette.idCycle)
//                       .contains(data.idCycle)
//                   ? Colors.green
//                   : Colors.red,
//               foregroundColor: Colors.white,
//               radius: 10,
//               child: Text(
//                 data.numCycle.toString(),
//               ),
//             ))
//         .toList();
//     return list;
//   }
// }
  List<Widget> _generateCircleAvatars(
    List<Cycle> cycleList,
    CorCyclePlacetteList corCyclePlacetteList,
    CorCyclePlacetteLocalStorageStatusNotifier
        corCyclePlacetteLocalStorageStatusProvider,
  ) {
    return cycleList.map<Widget>((Cycle data) {
      CorCyclePlacette? currentCorCyclePlacette;

      // Iterate over corCyclePlacetteList to find the matching element
      for (var corCyclePlacette in corCyclePlacetteList.values) {
        if (corCyclePlacette.idCycle == data.idCycle) {
          currentCorCyclePlacette = corCyclePlacette;
          break; // Break the loop once the matching element is found
        }
      }

      // Determine the cycle completion status
      bool isCyclePlacetteInProgress = false;
      if (currentCorCyclePlacette != null) {
        isCyclePlacetteInProgress = corCyclePlacetteLocalStorageStatusProvider
            .isCyclePlacetteInProgress(currentCorCyclePlacette.idCyclePlacette);
      }

      // Determine the background color
      Color backgroundColor = isCyclePlacetteInProgress
          ? Colors.yellow // Yellow for not completed
          : (currentCorCyclePlacette != null
              ? Colors.green
              : Colors.red); // Green if CorCyclePlacette exists, otherwise red

      return CircleAvatar(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        radius: 10,
        child: Text(data.numCycle.toString()),
      );
    }).toList();
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
    case 'Reperes':
    case 'Repères':
      return items.getObjectFromId(value['idRepere']);
    case 'Transects':
      return items.getObjectFromId(value['idTransectOrig']);
    default:
      throw ArgumentError('Unknown type: ${items.runtimeType}');
  }
}

Cycle? getCycleFromType(String formType, CycleList dispCycleList,
    [SaisisableObject? selectedItemMesureDetails]) {
  if (formType == 'edit') {
    if (selectedItemMesureDetails is ArbreMesure) {
      return dispCycleList.findCycleById(selectedItemMesureDetails.idCycle);
    } else if (selectedItemMesureDetails is BmSup30Mesure) {
      return dispCycleList.findCycleById(selectedItemMesureDetails.idCycle);
    } else if (selectedItemMesureDetails is CorCyclePlacette) {
      CorCyclePlacette aaa = selectedItemMesureDetails as CorCyclePlacette;
      return dispCycleList.findCycleById(aaa.idCycle);
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
  String formType,
  CorCyclePlacetteList corCyclePlacetteList,
  CycleList dispCycleList,
) {
  Cycle? cycle = dispCycleList.findIdOfCycleWithLargestNumCycle();
  // Get the idCyclePlacette of the corCyclePlacette corresponding to the cycle
  if (formType == 'add' || formType == 'newMesure') {
    return corCyclePlacetteList.getCorCyclePlacetteByIdCycle(cycle!.idCycle);
  } else {
    return null;
  }
}
