import 'package:dendro3/domain/model/arbre_list.dart';
import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:dendro3/domain/model/corCyclePlacette_list.dart';
import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/cycle_list.dart';
import 'package:dendro3/domain/model/displayable_list.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/model/placette_list.dart';
import 'package:dendro3/presentation/viewmodel/baseList/arbre_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/displayable_list_notifier.dart';
import 'package:dendro3/presentation/viewmodel/dispositif/dispositif_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/placette/saisie_placette_viewmodel.dart';
import 'package:dendro3/presentation/widgets/saisie_data_table/saisie_data_table_service.dart';
import 'package:dendro3/core/types/saisie_data_table_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;
import 'package:data_table_2/data_table_2.dart';

import 'package:flutter/scheduler.dart';

class SaisieDataTable extends ConsumerStatefulWidget {
  SaisieDataTable(
      {super.key,
      required this.placetteId,
      // required this.itemList,
      required this.dispCycleList,
      required this.corCyclePlacetteList});

  // final ArbreList itemList;
  final int placetteId;
  final CycleList dispCycleList;
  final CorCyclePlacetteList corCyclePlacetteList;

  @override
  SaisieDataTableState createState() => SaisieDataTableState();
}

class SaisieDataTableState extends ConsumerState<SaisieDataTable> {
  final ScrollController _controller = ScrollController();
  double? arrayWidth;
  late List<bool> _extendedList;
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
          height: 400,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.green,
            border: Border(),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: DataTable2(
            columnSpacing: 12,
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

            rows: _createRows(cycleRowList),
          ),
        ),
        ToggleButtons(
          direction: Axis.horizontal,
          onPressed: (int index) {
            setState(() {
              for (int i = 0; i < _extendedList.length; i++) {
                _extendedList[i] = i == index;
              }
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
          children: <Widget>[Text('Compact'), Text('Extended')],
        ),
        // Toggle Button changeant l'affichage des colonnes globales
        ToggleButtons(
          direction: Axis.horizontal,
          onPressed: (int index) {
            ref.read(reducedToggleProvider.notifier).toggleChanged(index);
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
          isSelected:
              reducedList.isNotEmpty ? reducedList : [false, false, false],
          children: <Widget>[
            Text('All'),
            Text('Reduced'),
            Text('None'),
          ],
        ),
        // Toggle Button changeant l'affichage des colonnes de mesures
        ToggleButtons(
          direction: Axis.horizontal,
          onPressed: (int index) {
            ref.read(reducedMesureToggleProvider.notifier).toggleChanged(index);
          },
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          selectedBorderColor: Colors.green[700],
          selectedColor: Colors.white,
          fillColor: Colors.green[200],
          color: Colors.green[400],
          constraints: const BoxConstraints(
            minHeight: 40.0,
            minWidth: 80.0,
          ),
          isSelected: reducedMesureList.isNotEmpty
              ? reducedMesureList
              : [false, false, false],
          children: <Widget>[
            Text('All'),
            Text('Mesure Reduced'),
            Text('Sans Mesure'),
          ],
        ),
        Visibility(
          visible: [
            0,
            1
          ].contains(reducedMesureList.indexWhere((mesure) => mesure == true)),
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
                widget.corCyclePlacetteList,
              ),
            ],
          ),
        )
      ],
    );
  }
}

List<DataColumn> _createColumns(List<String> columnList) {
  return columnList
      .map(
        (columnStr) => DataColumn2(
          label: Text(columnStr),
          numeric: true,
        ),
      )
      .toList();
}

List<DataRow> _createRows(List<Map<String, dynamic>> valueList) {
  List<DataCell> cellList = [];
  return valueList.map<DataRow>((value) {
    cellList = value.values.map<DataCell>((yo) {
      return DataCell(
        Text(
          yo.toString(),
        ),
      );
    }).toList();
    return DataRow(
      cells: cellList,
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
