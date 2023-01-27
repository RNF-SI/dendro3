import 'package:dendro3/domain/model/arbre_list.dart';
import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:dendro3/domain/model/corCyclePlacette_list.dart';
import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/cycle_list.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/model/placette_list.dart';
import 'package:dendro3/presentation/viewmodel/dispositif/dispositif_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/placette/saisie_placette_viewmodel.dart';
import 'package:dendro3/presentation/widgets/saisie_data_table/saisie_data_table_service.dart';
import 'package:dendro3/core/types/saisie_data_table_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;
import 'package:data_table_2/data_table_2.dart';

class SaisieDataTable extends ConsumerStatefulWidget {
  SaisieDataTable(
      {super.key,
      required this.data,
      required this.dispCycleList,
      required this.corCyclePlacetteList});

  final ArbreList data;
  final CycleList dispCycleList;
  final CorCyclePlacetteList corCyclePlacetteList;

  @override
  SaisieDataTableState createState() => SaisieDataTableState();
}

class SaisieDataTableState extends ConsumerState<SaisieDataTable> {
  final ScrollController _controller = ScrollController();
  double? arrayWidth;
  final List<bool> _extendedList = <bool>[true, false];
  final List<bool> _reducedList = <bool>[true, false, false];
  final List<bool> _mesureList = <bool>[true, false, false];
  late List<bool> _cycleSelectedList;

  @override
  void initState() {
    _cycleSelectedList = widget.dispCycleList!.values
        .map<bool>((Cycle data) => data.numCycle == 1 ? true : false)
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final rowList = ref.watch(rowsProvider(widget.data));
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

            rows: _createRows(rowList),
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
            for (int i = 0; i < _reducedList.length; i++) {
              _reducedList[i] = i == index;
            }
            if (_reducedList[0] == true) {
              ref.read(displayedColumnTypeProvider.notifier).state =
                  DisplayedColumnType.all;
            } else if (_reducedList[1] == true) {
              ref.read(displayedColumnTypeProvider.notifier).state =
                  DisplayedColumnType.reduced;
            } else {
              ref.read(displayedColumnTypeProvider.notifier).state =
                  DisplayedColumnType.none;
            }
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
          isSelected: _reducedList,
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
            for (int i = 0; i < _mesureList.length; i++) {
              _mesureList[i] = i == index;
            }
            if (_mesureList[0] == true) {
              ref.read(displayedMesureColumnTypeProvider.notifier).state =
                  DisplayedColumnType.all;
            } else if (_mesureList[1] == true) {
              ref.read(displayedMesureColumnTypeProvider.notifier).state =
                  DisplayedColumnType.reduced;
            } else {
              ref.read(displayedMesureColumnTypeProvider.notifier).state =
                  DisplayedColumnType.none;
            }
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
          isSelected: _mesureList,
          children: <Widget>[
            Text('All'),
            Text('Mesure Reduced'),
            Text('Sans Mesure'),
          ],
        ),
        Visibility(
          visible: [0, 1]
              .contains(_mesureList.indexWhere((mesure) => mesure == true)),
          child: ToggleButtons(
            isSelected: _cycleSelectedList,
            onPressed: (int index) {
              setState(() {
                _cycleSelectedList[index] = !_cycleSelectedList[index];
                // TODO: Ajout logique de changement des row en fct du cycle
              });
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
                widget.dispCycleList!,
                widget.corCyclePlacetteList,
              ),
            ],
          ),
        ),
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
    CycleList cycleList, CorCyclePlacetteList corCyclePlacetteList) {
  var list = cycleList.values
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
