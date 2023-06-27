import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:dendro3/domain/model/corCyclePlacette_list.dart';
import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/cycle_list.dart';
import 'package:dendro3/presentation/lib/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacetteCycleWidget extends StatefulWidget {
  const PlacetteCycleWidget({
    Key? key,
    required this.corCyclePlacette,
    required this.dispCycleList,
  }) : super(key: key);

  final CorCyclePlacetteList? corCyclePlacette;
  final CycleList? dispCycleList;

  @override
  State<StatefulWidget> createState() => _PlacetteCycleWidgetState();
}

class _PlacetteCycleWidgetState extends State<PlacetteCycleWidget> {
  _PlacetteCycleWidgetState();

  late List<bool> cycleSelected;

  @override
  void initState() {
    cycleSelected =
        widget.dispCycleList!.values.map<bool>((Cycle data) => false).toList();
    cycleSelected[0] = true;

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
          ..._generateCircleAvatars(
            widget.dispCycleList!,
            widget.corCyclePlacette!,
          ),
        ],
      ),
      // Afficher le grid seulement si le corcycle existe pour la placette
      // Sinon Afficher un text et un bouton
      widget.corCyclePlacette!.values
              .map((CorCyclePlacette corCyclePla) => corCyclePla.idCycle)
              .contains(widget
                  .dispCycleList![
                      cycleSelected.indexWhere((selected) => selected == true)]
                  .idCycle)
          ? __buildGridText(widget.corCyclePlacette![
              cycleSelected.indexWhere((selected) => selected == true)])
          : NoCycleWidget(),
    ]);
  }
}

List<Widget> _generateCircleAvatars(
  CycleList dispCycleList,
  CorCyclePlacetteList corCyclePlacetteList,
) {
  var list = dispCycleList.values
      .map<Widget>((data) => CircleAvatar(
            backgroundColor: corCyclePlacetteList.values
                    .map((CorCyclePlacette corCycle) => corCycle.idCycle)
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

Widget __buildGridText(CorCyclePlacette corCyclePlacette) {
  return Expanded(
    child: SizedBox(
      height: 200.0,
      child: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          childAspectRatio: (1 / .2),
          children: [
            buildPropertyTextWidget(
                'idCyclePlacette', corCyclePlacette.idCyclePlacette),
            buildPropertyTextWidget('idCycle', corCyclePlacette.idCycle),
            buildPropertyTextWidget('idPlacette', corCyclePlacette.idPlacette),
            buildPropertyTextWidget(
                'dateReleve',
                corCyclePlacette.dateReleve != null
                    ? '${corCyclePlacette.dateReleve!.day}/${corCyclePlacette.dateReleve!.month}/${corCyclePlacette.dateReleve!.year}'
                    : null),
            buildPropertyTextWidget(
                'dateIntervention', corCyclePlacette.dateIntervention),
            buildPropertyTextWidget('annee', corCyclePlacette.annee),
            buildPropertyTextWidget(
                'natureIntervention', corCyclePlacette.natureIntervention),
            buildPropertyTextWidget(
                'gestionPlacette', corCyclePlacette.gestionPlacette),
            buildPropertyTextWidget(
                'idNomenclatureCastor', corCyclePlacette.idNomenclatureCastor),
            buildPropertyTextWidget('idNomenclatureFrottis',
                corCyclePlacette.idNomenclatureFrottis),
            buildPropertyTextWidget(
                'idNomenclatureBoutis', corCyclePlacette.idNomenclatureBoutis),
            buildPropertyTextWidget(
                'recouvHerbesBasses', corCyclePlacette.recouvHerbesBasses),
            buildPropertyTextWidget(
                'recouvHerbesHautes', corCyclePlacette.recouvHerbesHautes),
            buildPropertyTextWidget(
                'recouvBuissons', corCyclePlacette.recouvBuissons),
            buildPropertyTextWidget(
                'recouvArbres', corCyclePlacette.recouvArbres),
          ]),
    ),
  );
}

class NoCycleWidget extends StatefulWidget {
  @override
  _NoCycleWidgetState createState() => _NoCycleWidgetState();
}

class _NoCycleWidgetState extends State<NoCycleWidget> {
  String selectedText = "Ce cycle n'a pas été réalisé pour cette placette";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(selectedText),
        ElevatedButton(
          child: Text('Commencer le cycle'),
          onPressed: () {
            // Add your code here that you want to execute when the button is pressed.
          },
        ),
      ],
    );
  }
}
