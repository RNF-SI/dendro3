import 'package:dendro3/data/mapper/arbreMesure_mapper.dart';
import 'package:dendro3/data/mapper/arbre_mapper.dart';
import 'package:dendro3/data/mapper/bmSup30Mesure_mapper.dart';
import 'package:dendro3/data/mapper/bmSup30_mapper.dart';
import 'package:dendro3/data/mapper/corCyclePlacette_mapper.dart';
import 'package:dendro3/data/mapper/regeneration_mapper.dart';
import 'package:dendro3/data/mapper/repere_mapper.dart';
import 'package:dendro3/data/mapper/transect_mapper.dart';
import 'package:dendro3/domain/model/arbre_list.dart';
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
import 'package:dendro3/presentation/viewmodel/displayable_list_notifier.dart';
import 'package:dendro3/presentation/viewmodel/dispositif/dispositif_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/placette/saisie_placette_viewmodel.dart';
import 'package:dendro3/presentation/widgets/list_item_display.dart';
import 'package:dendro3/presentation/widgets/saisie_data_table/saisie_data_table_service.dart';
import 'package:dendro3/core/types/saisie_data_table_types.dart';
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
    List<bool> reducedList = ref.watch(reducedToggleProvider);
    List<bool> reducedMesureList = ref.watch(reducedMesureToggleProvider);
    List<bool> cycleToggleSelectedList = ref.watch(cycleSelectedToggleProvider);

    final DisplayableList items = ref.watch(displayableListProvider);

    final rowList = ref.watch(rowsProvider(items));
    final cycleRowList = ref.watch(cycleRowsProvider(rowList));
    final columnNameList = ref.watch(columnsProvider(rowList));
    final arrayWidth = ref.watch(arrayWidthProvider(columnNameList));

    return Column(
      children: [
        Container(
          height: 300,
          padding: EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            color: Colors.green,
            // border: Border(),
            // borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: columnNameList.isEmpty
              ? Text('An error occurred: columnNameList is null.')
              : DataTable2(
                  columnSpacing: 10,
                  horizontalMargin: 4,
                  fixedLeftColumns: 1,

                  // fixedLeftColumns: 1,
                  scrollController: _controller,
                  dividerThickness: 0,
                  // dataRowHeight: 300,
                  showCheckboxColumn: false,
                  // bottomMargin: 10,

                  // scrollController: _controller,
                  // horizontalMargin: 10,
                  // columnSpacing: 30, //defaultPadding,
                  minWidth: _extendedList[0] ? null : arrayWidth,
                  columns: _createColumns(columnNameList),

                  rows: _createRows(cycleRowList, items),
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
        if (selectedItemDetails != null) _buildSelectedItemDetails(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Visibility(
              visible: selectedItemDetails != null,
              child: ElevatedButton(
                onPressed: () {
                  // Logic for updating an item
                  Navigator.push(context, MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return FormSaisiePlacettePage(
                        formType: "edit",
                        type: widget.displayTypeState,
                        placette: widget.placette,
                        cycle:
                            widget.dispCycleList.values[0], // Modify as needed
                        // saisisableObject1: convertToSaisisObject1(
                        //     selectedItemDetails!, widget.displayTypeState),
                        // saisisableObject2: convertToSaisisObject2(
                        //     selectedItemDetails!, widget.displayTypeState),
                      );
                    },
                  ));
                },
                child: Text("Modifier l'${widget.displayTypeState}"),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                // Logic for deleting an item
              },
              child: Text('Supprimer'),
            ),
            const SizedBox(width: 10),
            // Button for deleting an item
            ElevatedButton(
              onPressed: () {
                // Logic for deleting an item
              },
              child: Text('Nouvelle Mesure'),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return FormSaisiePlacettePage(
                formType: "add",
                type: widget.displayTypeState,
                placette: widget.placette,
                cycle: widget.dispCycleList.values[0],
              );
            },
          )),
          child: Text('Ajouter un ${widget.displayTypeState}'),
        ),
      ],
    );
  }

  Widget _buildSelectedItemDetails() {
    // Check if selectedItemDetails is null
    if (selectedItemDetails == null) {
      return Text("No item selected.");
    }

    List<MapEntry<String, dynamic>> simpleElements = [];
    List<dynamic> arbresMesuresList = [];

    // Extracting the data
    var allValues = selectedItemDetails!.getAllValuesMapped();
    allValues.entries.forEach((entry) {
      if (entry.key == "arbresMesures" && entry.value is List) {
        arbresMesuresList = entry.value;
      } else {
        simpleElements.add(entry);
      }
    });

    return Column(
      children: [
        createPrimaryGrid(simpleElements),
        // Only create SecondaryGrid if arbresMesuresList is not empty
        if (arbresMesuresList.isNotEmpty)
          SecondaryGrid(arbresMesuresList: arbresMesuresList),
      ],
    );
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
      List<Map<String, dynamic>> valueList, DisplayableList items) {
    return valueList.map<DataRow>((value) {
      List<DataCell> cellList = [];

      // Ajouter une cellule pour la colonne "update" au début
      cellList.add(
        DataCell(
          SizedBox(
            width: 32, // Adjust the width as needed
            height: 24,
            child: IconButton(
              padding: EdgeInsets.only(left: 12),
              icon: Icon(
                Icons.select_all,
                size: 24,
              ),
              onPressed: () {
                setState(() {
                  selectedItemDetails =
                      getObjectFromType(value, items, widget.displayTypeState);
                });
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

      return DataRow(cells: cellList);
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
      return items.getObjectFromId(value['idTransectOrig']);
    default:
      throw ArgumentError('Unknown type: ${items.runtimeType}');
  }
}
