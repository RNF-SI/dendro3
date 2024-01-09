import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/cycle_list.dart';
import 'package:dendro3/presentation/lib/utils.dart';
import 'package:flutter/material.dart';

class ChiffresWidget extends StatefulWidget {
  const ChiffresWidget({
    Key? key,
    required this.cycleList,
  }) : super(key: key);

  final CycleList? cycleList;

  @override
  State<StatefulWidget> createState() => _ChiffresWidgetState();
}

class _ChiffresWidgetState extends State<ChiffresWidget> {
  _ChiffresWidgetState();

  late List<bool> cycleSelected;

  @override
  void initState() {
    cycleSelected = widget.cycleList!.values
        .map<bool>((Cycle data) => data.numCycle == 1 ? true : false)
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ToggleButtons(
        isSelected: cycleSelected,
        onPressed: (int index) {
          setState(() {
            for (int i = 0; i < cycleSelected.length; i++) {
              cycleSelected[i] = i == index;
            }
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
          ..._generateCircleAvatars(widget.cycleList!),
        ],
      ),
      ...__buildGridText(
        widget.cycleList![
            cycleSelected.indexWhere((selected) => selected == true)],
      ),
    ]);
  }
}

List<Widget> _generateCircleAvatars(CycleList cycleList) {
  var list = cycleList.values
      .map<Widget>((data) => CircleAvatar(
            backgroundColor: data.dateFin == null ? Colors.red : Colors.green,
            foregroundColor: Colors.white,
            radius: 10,
            child: Text(
              data.numCycle.toString(),
            ),
          ))
      .toList();
  return list;
}

List<Widget> __buildGridText(Cycle cycle) {
  return [
    SizedBox(
      height: 200.0,
      child: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          childAspectRatio: (1 / .2),
          children: [
            buildPropertyTextWidget('idCycle', cycle.idCycle),
            buildPropertyTextWidget('idDispositif', cycle.idDispositif),
            buildPropertyTextWidget('numCycle', cycle.numCycle),
            buildPropertyTextWidget('coeff', cycle.coeff),
            buildPropertyTextWidget(
                'dateDebut',
                cycle.dateDebut != null
                    ? '${cycle.dateDebut!.day}/${cycle.dateDebut!.month}/${cycle.dateDebut!.year}'
                    : null),
            buildPropertyTextWidget(
                'dateFin',
                cycle.dateFin != null
                    ? '${cycle.dateFin!.day}/${cycle.dateFin!.month}/${cycle.dateFin!.year}'
                    : null),
            buildPropertyTextWidget('diamLim', cycle.diamLim),
            buildPropertyTextWidget('monitor', cycle.monitor),
          ]),
    ),
    Tooltip(
      message: "Calculé en fonction de DateFin.\n"
          "Avertissez le responsable PSDRF \npour actualiser.",
      triggerMode: TooltipTriggerMode.tap,
      child: cycle.dateFin == null
          ? const Text("Ce cycle est en cours")
          : const Text("Ce cycle est terminé"),
    )
  ];
}
