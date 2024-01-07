import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:dendro3/domain/model/corCyclePlacette_list.dart';
import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/cycle_list.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/presentation/lib/utils.dart';
import 'package:dendro3/presentation/view/form_saisie_placette_page.dart';
import 'package:dendro3/presentation/viewmodel/corCyclePlacetteList/cor_cycle_placette_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacetteCycleWidget extends ConsumerStatefulWidget {
  const PlacetteCycleWidget({
    Key? key,
    required this.placette,
    required this.corCyclePlacetteList,
    required this.dispCycleList,
  }) : super(key: key);

  final Placette placette;
  final CorCyclePlacetteList corCyclePlacetteList;
  final CycleList? dispCycleList;

  @override
  PlacetteCycleWidgetState createState() => PlacetteCycleWidgetState();
}

class PlacetteCycleWidgetState extends ConsumerState<PlacetteCycleWidget> {
  PlacetteCycleWidgetState();

  late List<bool> cycleSelected;

  @override
  void initState() {
    super.initState();
    cycleSelected =
        widget.dispCycleList!.values.map<bool>((Cycle data) => false).toList();
    if (cycleSelected.isNotEmpty) {
      cycleSelected[0] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Fetch the ViewModel instance
    final corCyclePlacetteListViewModel =
        ref.watch(corCyclePlacetteListViewModelStateNotifierProvider.notifier);

    // Determine the selected cycle's idCycle
    int selectedCycleIndex = cycleSelected.indexWhere((selected) => selected);
    Cycle? selectedCycle = selectedCycleIndex != -1
        ? widget.dispCycleList!.values.elementAt(selectedCycleIndex)
        : null;

    CorCyclePlacette? selectedCorCyclePlacette;

    // Iterate over corCyclePlacetteList to find the matching element
    for (var corCyclePlacette in widget.corCyclePlacetteList.values) {
      if (selectedCycle != null &&
          corCyclePlacette.idCycle == selectedCycle!.idCycle) {
        selectedCorCyclePlacette = corCyclePlacette;
        break; // Break the loop once the matching element is found
      }
    }

    // Check if the cycle placette is new using idCyclePlacette
    bool isNewCycle = selectedCorCyclePlacette != null &&
        corCyclePlacetteListViewModel
            .isCyclePlacetteCreated(selectedCorCyclePlacette.idCyclePlacette);

    // Ensure that ViewModel instance is used correctly in _generateCircleAvatars
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
        children: _generateCircleAvatars(
          widget.dispCycleList!,
          widget.corCyclePlacetteList!,
          corCyclePlacetteListViewModel, // Pass the ViewModel instance here
        ),
      ),

      // Conditionally render the "Mark as Complete" button
      if (isNewCycle)
        ElevatedButton(
          onPressed: () async {
            await corCyclePlacetteListViewModel
                .completeCycle(selectedCorCyclePlacette!.idCyclePlacette);
            setState(() {}); // Refresh the UI
          },
          child: const Text('Marquer comme complet'),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue)),
        ),

      // Afficher le grid seulement si le corcycle existe pour la placette
      // Sinon Afficher un text et un bouton
      widget.corCyclePlacetteList!.values
              .map((CorCyclePlacette corCyclePla) => corCyclePla.idCycle)
              .contains(widget
                  .dispCycleList![
                      cycleSelected.indexWhere((selected) => selected == true)]
                  .idCycle)
          ? __buildGridText(widget.corCyclePlacetteList![
              cycleSelected.indexWhere((selected) => selected == true)])
          : NoCycleWidget(
              placette: widget.placette,
              cycle: widget.dispCycleList![
                  cycleSelected.indexWhere((selected) => selected == true)]),
    ]);
  }
}

List<Widget> _generateCircleAvatars(
  CycleList dispCycleList,
  CorCyclePlacetteList corCyclePlacetteList,
  CorCyclePlacetteListViewModel viewModel,
) {
  return dispCycleList.values.map<Widget>((Cycle data) {
    CorCyclePlacette? correspondingCorCyclePlacette;

    // Iterate over corCyclePlacetteList to find the matching element
    for (var corCyclePlacette in corCyclePlacetteList.values) {
      if (corCyclePlacette.idCycle == data.idCycle) {
        correspondingCorCyclePlacette = corCyclePlacette;
        break; // Break the loop once the matching element is found
      }
    }

    // Check if the cycle placette is new using idCyclePlacette
    bool isNewCycle = correspondingCorCyclePlacette != null
        ? viewModel.isCyclePlacetteCreated(
            correspondingCorCyclePlacette.idCyclePlacette)
        : false;

    Color backgroundColor = isNewCycle
        ? Colors.yellow // New cycle color
        : correspondingCorCyclePlacette != null
            ? Colors.green // Existing cycle
            : Colors.red; // Cycle not found
    return CircleAvatar(
      backgroundColor: backgroundColor,
      foregroundColor: Colors.white,
      radius: 10,
      child: Text(
        data.numCycle.toString(),
      ),
    );
  }).toList();
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

class NoCycleWidget extends ConsumerWidget {
  NoCycleWidget({Key? key, required this.placette, required this.cycle})
      : super(key: key);

  Placette placette;
  Cycle cycle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text("Ce cycle n'a pas été réalisé pour cette placette"),
        ElevatedButton(
          child: Text("Button"),
          onPressed: () => Navigator.push(context, MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return FormSaisiePlacettePage(
                formType: "add",
                type: 'corCyclePlacette',
                placette: placette,
                cycle: cycle,
                corCyclePlacette: null,

                // placette: placette,
                // cycle: dispCycleList.values[0],
              );
            },
          )),
        ),
      ],
    );
  }
}
