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
  late List<bool> cycleSelected;

  @override
  void initState() {
    cycleSelected = widget.cycleList!.values
        .map<bool>((Cycle data) => data.numCycle == 1)
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          selectedBorderColor: Color(0xFF598979),
          selectedColor: Colors.white,
          fillColor: Color(0xFF7DAB9C),
          color: Color(0xFF8AAC3E),
          constraints: const BoxConstraints(minHeight: 40.0, minWidth: 90.0),
          children: _generateCircleAvatars(widget.cycleList!),
        ),
        // display if cycleList is not empty else display info about no cycle was defined
        if (widget.cycleList?.length != 0)
          ..._buildGridText(
            widget.cycleList![
                cycleSelected.indexWhere((bool selected) => selected)],
          ),
        if (widget.cycleList?.length == 0)
          const Text("Aucun cycle n'a été défini pour ce dispositif"),
      ],
    );
  }

  List<Widget> _generateCircleAvatars(CycleList cycleList) {
    return cycleList.values.map<Widget>((Cycle data) {
      return CircleAvatar(
        backgroundColor:
            data.dateFin == null ? Color(0xFF8B5500) : Color(0xFF598979),
        foregroundColor: Colors.white,
        radius: 15,
        child: Text(data.numCycle.toString()),
      );
    }).toList();
  }

  List<Widget> _buildGridText(Cycle cycle) {
    return [
      SizedBox(
        height: 200.0,
        child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: (1 / .2),
            children: [
              buildPropertyTextWidget('idCycle', cycle.idCycle),
              buildPropertyTextWidget('idDispositif', cycle.idDispositif),
              buildPropertyTextWidget('numCycle', cycle.numCycle),
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
}
